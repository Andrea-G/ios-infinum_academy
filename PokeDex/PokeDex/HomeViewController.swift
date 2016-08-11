//
//  HomeViewController.swift
//  PokeDex
//
//  Created by Infinum on 09/07/16.
//  Copyright © 2016 Infinum. All rights reserved.
//

import UIKit

import Alamofire
import Unbox
import MBProgressHUD

class HomeViewController: UIViewController, PokemonAddedDelegate, RemoveUser{
    
    var user: User!
    var authorization: String = ""
    var pokemons = [Pokemon]()
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Pokedex"
        
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
    }
    
    @IBAction func logoutButtonClick(sender: AnyObject) {
        userLogout(user.authorization)
    }
    
    @IBAction func addPokemonButtonClick(sender: AnyObject) {
        
        let viewController = storyboard?.instantiateViewControllerWithIdentifier("addPokemon") as! AddPokemonViewController
        viewController.user = user
        viewController.delegate = self
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func didAddPokemon(name: String) {
        getPokemons(user.authorization)
    }
    
    func adjustRoundImage(imageView: UIImageView?){
        
        var layer: CALayer = CALayer()
        layer = (imageView?.layer)!
        
        layer.masksToBounds = true
        layer.cornerRadius = CGFloat(25)
        
        let itemSize = CGSizeMake(50, 50)
        UIGraphicsBeginImageContextWithOptions(itemSize, false, UIScreen.mainScreen().scale)
        let imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height)
//        
//        if imageView?.image == nil {
//            imageView?.image = UIImage(named: "image_placeholder")
//        }
        
        imageView?.image!.drawInRect(imageRect)
        imageView?.image! = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()
    }
    

}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("pokemonListCell") as UITableViewCell!
        
        cell.textLabel?.text = pokemons[indexPath.row].name
        cell.imageView?.contentMode = .ScaleAspectFit
        
        if let imageUrl = pokemons[indexPath.row].imageUrl {
            
            let url:NSURL = NSURL(string: "https://pokeapi.infinum.co" + imageUrl)!
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {

                guard let imageData = NSData(contentsOfURL: url) else {
                    return
                }
                
                guard let image = UIImage(data: imageData) else {
                    return
                }
                print("img")
                print(image)
                
                dispatch_async(dispatch_get_main_queue(), {
                    
                    print(image)
                    print(cell.imageView?.image)
                    cell.imageView?.image = image
                    print(cell.imageView?.image)
                    self.adjustRoundImage(cell.imageView)
                })
            }
        }
        
        return cell
    }
    
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let viewController = storyboard?.instantiateViewControllerWithIdentifier("pokemonDetails") as! PokemonDetailsTableViewController
        viewController.user = user
        viewController.pokemon = pokemons[indexPath.row]
        viewController.getComments(user.authorization)
        navigationController?.pushViewController(viewController, animated: true)
    }
}


extension HomeViewController : PokemonGettable {
    
    func getPokemons(authorization: String){
        
        let headers = ["Authorization": authorization,]
        MBProgressHUD.showHUDAddedTo(view, animated: true)
        
        Alamofire.request(.GET, "https://pokeapi.infinum.co/api/v1/pokemons", headers: headers, encoding: .JSON).validate().responseJSON
            { (response) in
                
                MBProgressHUD.hideHUDForView(self.view, animated: true)
                switch response.result {
                case .Success:
                    print("Successful")

                    do {
                        let data = response.data!
                        let pokemonList : PokemonList = try Unbox(data)
                        print("\(pokemonList.pokemons)")
                        
                        self.pokemons = pokemonList.pokemons
                        self.tableView.reloadData()
                        
                    } catch _ {
                        print("Failed")
                    }
                case .Failure(let error):
                    print(error)
                }
        }
    }
}

extension HomeViewController : Logout {

    func userLogout(authorization: String) {
        
        let headers = [
            "Authorization": authorization,
            ]
        
        Alamofire.request(.DELETE, "https://pokeapi.infinum.co/api/v1/users/logout", headers: headers, encoding: .JSON).validate().responseJSON
            { (response) in
                
                switch response.result {
                case .Success:
                    print("Logout Successful")
                    print("\(response)")
                    self.removeUser()
                    
                case .Failure(let error):
                    print(error)
                }
        }
        
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
}
