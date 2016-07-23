//
//  HomeViewController.swift
//  PokeDex
//
//  Created by Infinum on 09/07/16.
//  Copyright © 2016 Infinum. All rights reserved.
//

import UIKit

import Alamofire

class HomeViewController: UIViewController {
    
    var user: User!

    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Pokedex"
        
        //let image = UIImage(named: "icon_logout")
        
        let button = UIButton(type: .Custom) as? UIButton
        button?.setImage(UIImage(named: "icon_logout"), forState: UIControlState.Normal)
        button?.addTarget(self, action:#selector(HomeViewController.logoutButtonClick), forControlEvents: UIControlEvents.TouchUpInside)
        button?.frame=CGRectMake(0, 0, 30, 30)
        let barButton = UIBarButtonItem(customView: button!)
        self.navigationItem.leftBarButtonItem = barButton
        
        //print(user)
        
        // Do any additional setup after loading the view.
    }
    
    func logoutButtonClick() {
        
        let authorization = "Token token=" + user.authToken + ", email=" + user.email
        
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
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("pokemonListCell") as UITableViewCell!
        
        cell.textLabel?.text = "Section: \(indexPath.section), Row: \(indexPath.row)"
        
        return cell
    }
    
}