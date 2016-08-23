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
import Kingfisher

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

}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("pokemonListCell") as! PokemonListTableViewCell
        
        cell.pokemonNameLabel.text = pokemons[indexPath.row].name
        cell.pokemonImage.contentMode = .ScaleAspectFit
        cell.pokemonImage.layer.masksToBounds = false
        cell.pokemonImage.layer.cornerRadius = cell.pokemonImage.frame.height/2
        cell.pokemonImage.clipsToBounds = true
        
        if let imageUrl = pokemons[indexPath.row].imageUrl {
            
            let stringUrl = "https://pokeapi.infinum.co" + imageUrl
            
            cell.pokemonImage.kf_setImageWithURL(NSURL(string: stringUrl)!, placeholderImage: UIImage(named: "image_placeholder"), completionHandler: { (image, error, cacheType, imageURL) -> () in
                

            })
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
