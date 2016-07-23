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

class HomeViewController: UIViewController {
    
    var user: User!
    var authorization: String = ""
    var pokemons: [Pokemon]!

    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Pokedex"
        
        authorization = "Token token=" + user.authToken + ", email=" + user.email
        
        //let image = UIImage(named: "icon_logout")
        
        let button = UIButton(type: .Custom)
        button.setImage(UIImage(named: "icon_logout"), forState: UIControlState.Normal)
        button.addTarget(self, action:#selector(HomeViewController.logoutButtonClick), forControlEvents: UIControlEvents.TouchUpInside)
        button.frame=CGRectMake(0, 0, 30, 30)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = barButton
        //print(user)
        
        print(pokemons)
        // Do any additional setup after loading the view.
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
                    
                case .Failure(let error):
                    print(error)
                }
        }

        self.navigationController?.popToRootViewControllerAnimated(true)
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
            let url:NSURL = NSURL(string: imageUrl)!
            let data:NSData = NSData(contentsOfURL: url)!
            cell.imageView?.image = UIImage(data: data)
        }

        
        return cell
    }
    
}