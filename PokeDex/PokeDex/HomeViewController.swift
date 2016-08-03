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
        
        authorization = user.authorization
        
        //let image = UIImage(named: "icon_logout")
        
        addLeftBarButtonItem()
        addRightBarButtonItem()
        
    }
    
    func addLeftBarButtonItem(){
        
        let logoutButton = UIButton(type: .Custom)
        logoutButton.setImage(UIImage(named: "icon_logout"), forState: UIControlState.Normal)
        logoutButton.addTarget(self, action:#selector(HomeViewController.logoutButtonClick), forControlEvents: UIControlEvents.TouchUpInside)
        logoutButton.frame=CGRectMake(0, 0, 50, 50)
        let barButtonLeft = UIBarButtonItem(customView: logoutButton)
        self.navigationItem.leftBarButtonItem = barButtonLeft
        
    }
    
    func addRightBarButtonItem(){
        
        let addPokemonButton = UIButton(type: .Custom)
        addPokemonButton.setImage(UIImage(named: "add_image_button"), forState: UIControlState.Normal)
        addPokemonButton.addTarget(self, action:#selector(HomeViewController.addPokemonButtonClick), forControlEvents: UIControlEvents.TouchUpInside)
        addPokemonButton.frame=CGRectMake(0, 0, 50, 50)
        let barButtonRight = UIBarButtonItem(customView: addPokemonButton)
        self.navigationItem.rightBarButtonItem = barButtonRight
    }
    
    func logoutButtonClick() {
        
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
    
    func addPokemonButtonClick() {
        
        let viewController = storyboard?.instantiateViewControllerWithIdentifier("addPokemon") as! AddPokemonViewController
        viewController.user = user
        viewController.delegate = self
        navigationController?.pushViewController(viewController, animated: true)
        

    }
    
    func didAddPokemon(name: String) {
        getPokemons()
    }
    

}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("pokemonListCell") as UITableViewCell!
        
        cell.textLabel?.text = pokemons[indexPath.row].name
        if let imageUrl = pokemons[indexPath.row].imageUrl {
            let url:NSURL = NSURL(string: "https://pokeapi.infinum.co" + imageUrl)!
            if let data:NSData = NSData(contentsOfURL: url) {
                cell.imageView?.image = UIImage(data: data)
                cell.imageView?.contentMode = .ScaleAspectFit
                
            }
        }
        
        return cell
    }
    
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let viewController = storyboard?.instantiateViewControllerWithIdentifier("pokemonDetails") as! PokemonDetailsTableViewController
        viewController.pokemon = pokemons[indexPath.row]
        navigationController?.pushViewController(viewController, animated: true)
    }
}


extension HomeViewController : PokemonGettable {
    
    func getPokemons(){
        
        let headers = ["Authorization": user.authorization,]
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
