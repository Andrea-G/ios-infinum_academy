//
//  AddPokemonViewController.swift
//  PokeDex
//
//  Created by Infinum on 01/08/16.
//  Copyright © 2016 Infinum. All rights reserved.
//

import UIKit

class AddPokemonViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var pokemonImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Add new Pokemon"

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 68
        
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addImageButtonClick(sender: AnyObject) {
        
        
    }
    
    @IBAction func saveButtonClick(sender: AnyObject) {
        
        
        var indexPath = NSIndexPath(forRow: 1, inSection: 0)
        var cell = tableView.cellForRowAtIndexPath(indexPath) as? AddPokemonTableViewCell
        
        let name = cell?.textView.text
        
        indexPath = NSIndexPath(forRow: 2, inSection: 0)
        cell = tableView.cellForRowAtIndexPath(indexPath) as? AddPokemonTableViewCell
        
        let height = cell?.textView.text
        
        indexPath = NSIndexPath(forRow: 3, inSection: 0)
        cell = tableView.cellForRowAtIndexPath(indexPath) as? AddPokemonTableViewCell
        
        let weight = cell?.textView.text
        
        indexPath = NSIndexPath(forRow: 4, inSection: 0)
        cell = tableView.cellForRowAtIndexPath(indexPath) as? AddPokemonTableViewCell
        
        let type = cell?.textView.text
        
        indexPath = NSIndexPath(forRow: 5, inSection: 0)
        cell = tableView.cellForRowAtIndexPath(indexPath) as? AddPokemonTableViewCell
        
        let abilities = cell?.textView.text
        
        indexPath = NSIndexPath(forRow: 6, inSection: 0)
        cell = tableView.cellForRowAtIndexPath(indexPath) as? AddPokemonTableViewCell
        
        let description = cell?.textView.text
        
//        let parameters = ["username": username!, "password": password!, "email": email!, "password_confirmation": password_confirmation!]
//        let data = ["type": "users", "attributes": parameters]
//        let params = ["data": data]
//        
//        MBProgressHUD.showHUDAddedTo(view, animated: true)
//        
//        Alamofire.request(.POST, "https://pokeapi.infinum.co/api/v1/users", parameters: params, encoding: .JSON).validate().responseJSON
//            { (response) in
//                
//                MBProgressHUD.hideHUDForView(self.view, animated: true)
//                switch response.result {
//                case .Success:
//                    print("Validation Successful")
//                    print("\(response)")
//                    do {
//                        if let data = response.data {
//                            let user: User = try Unbox(data)
//                            print("\(user)")
//                            
//                            self.getPokemons(user)
//                        }
//                        
//                    } catch _ {
//                        print("Failed")
//                    }
//                case .Failure(let error):
//                    print(error)
//                }
//        }
    }

}


extension AddPokemonViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("pokemonInfo") as UITableViewCell!
            
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier("textViews") as! AddPokemonTableViewCell
            
            cell.textView.placeholder = "Name"
            cell.infoImage.image = UIImage(named: "icon_person")
            cell.infoImage.contentMode = .Center
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCellWithIdentifier("textViews") as! AddPokemonTableViewCell
            
            cell.textView.placeholder = "Height"
            return cell
            
        case 3:
            let cell = tableView.dequeueReusableCellWithIdentifier("textViews") as! AddPokemonTableViewCell
            
            cell.textView.placeholder = "Weight"
            return cell
            
        case 4:
            let cell = tableView.dequeueReusableCellWithIdentifier("textViews") as! AddPokemonTableViewCell
            
            cell.textView.placeholder = "Type"
            return cell
            
        case 5:
            let cell = tableView.dequeueReusableCellWithIdentifier("textViews") as! AddPokemonTableViewCell
            
            cell.textView.placeholder = "Abilities"
            return cell
            
        case 6:
            let cell = tableView.dequeueReusableCellWithIdentifier("textViews") as! AddPokemonTableViewCell
            
            cell.textView.placeholder = "Description"
            return cell
            
        default:
            fatalError("Unexpected row")
        }
        
        
    }
    
}