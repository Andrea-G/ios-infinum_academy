//
//  PokemonDetailsTableViewController.swift
//  PokeDex
//
//  Copyright © 2016 Infinum. All rights reserved.
//

import UIKit

class PokemonDetailsTableViewController: UITableViewController {
    
    var pokemon: Pokemon!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = pokemon.name
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 400
        
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView.allowsSelection = false
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 9
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch indexPath.row {
            
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("pokeImage") as! ImageTableViewCell
            
            if let imageUrl = pokemon.imageUrl {
                let url:NSURL = NSURL(string: "https://pokeapi.infinum.co" + imageUrl)!
                
                if let data: NSData = NSData(contentsOfURL: url){
                    cell.img.image = UIImage(data: data)
                    cell.img.contentMode = .ScaleAspectFit
                }
            }

            return cell
        
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier("general") as! PokemonGeneralDetailsTableViewCell
            
            cell.pokemonNameLabel.text = pokemon.name
            cell.pokemonInfoLabel.text = pokemon.description
            
            return cell
        
        case 2:
            
            let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("infoDetail") as UITableViewCell!
            cell.textLabel?.text = "Height"
            
            if let pokemonHeight = pokemon.height {
                cell.detailTextLabel?.text = String(pokemonHeight)
            } else {
                cell.detailTextLabel?.text = ""
            }
            
            return cell
            
        case 3:
            let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("infoDetail") as UITableViewCell!
            cell.textLabel?.text = "Weight"
            
            if let pokemonWeigth = pokemon.weight {
                cell.detailTextLabel?.text = String(pokemonWeigth)
            } else {
                cell.detailTextLabel?.text = ""
            }
            
            return cell
            
            
        case 4:
            //gender al ne postoji gender u pokemon attributes
            let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("infoDetail") as UITableViewCell!
            cell.textLabel?.text = "Gender"
            
            if let pokemonGender = pokemon.gender {
                cell.detailTextLabel?.text = String(pokemonGender)
            } else {
                cell.detailTextLabel?.text = ""
            }
            
            return cell
            
        case 5:
            let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("likeDislike") as UITableViewCell!
            
            return cell
            
        case 6:
            let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("comments") as UITableViewCell!
            
            return cell
            
        case 7:
            let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("comment") as UITableViewCell!
            cell.textLabel?.text = "user"
            cell.detailTextLabel?.text = "some comment"
            
            return cell
            
        case 8:
            let cell = tableView.dequeueReusableCellWithIdentifier("editText") as! EditTextWithImageTableViewCell
            
            cell.textView.placeholder = "Add comment"
            cell.textView.addTarget(self, action:#selector(PokemonDetailsTableViewController.addCommentClick), forControlEvents: UIControlEvents.AllEvents)
            
            let image = UIImage(named: "add_image_button") as UIImage?
            cell.rightButton.setImage(image, forState: .Normal)
            
            return cell
            
        default:
            fatalError("Unexpected row")
        }
        
    }
    
    func addCommentClick(){
        
        let vc = storyboard?.instantiateViewControllerWithIdentifier("commentPopup")
        vc?.modalPresentationStyle = .OverCurrentContext
        navigationController?.presentViewController(vc!, animated: true, completion: {
            
        })
    }

}
