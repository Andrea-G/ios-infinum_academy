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

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 7
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("comment") as UITableViewCell!
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("general") as! PokemonGeneralDetailsTableViewCell
            
            cell.pokemonNameLabel.text = pokemon.name
            cell.pokemonInfoLabel.text = pokemon.description
            print(pokemon.description)
            if let imageUrl = pokemon.imageUrl {
                let url:NSURL = NSURL(string: imageUrl)!
                let data:NSData = NSData(contentsOfURL: url)!
                cell.imageView?.image = UIImage(data: data)
            }
            
            print(cell.pokemonInfoLabel)
            print(cell.pokemonNameLabel)
            return cell
        
        case 1:
            
            let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("infoDetail") as UITableViewCell!
            cell.textLabel?.text = "Height"
            cell.detailTextLabel?.text = String(pokemon.height)
            
            return cell
            
        case 2:
            let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("infoDetail") as UITableViewCell!
            cell.textLabel?.text = "Weight"
            cell.detailTextLabel?.text = String(pokemon.weight)
            
            return cell
            
            
        case 3:
            //gender al ne postoji gender u pokemon attributes
            let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("infoDetail") as UITableViewCell!
            cell.textLabel?.text = "Gender"
            cell.detailTextLabel?.text = String(pokemon.gender)
            
            return cell
            
        case 4:
            let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("likeDislike") as UITableViewCell!
            
            return cell
            
        case 5:
            let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("comments") as UITableViewCell!
            
            return cell
            
        case 6:
            let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("comment") as UITableViewCell!
            cell.textLabel?.text = "user"
            cell.detailTextLabel?.text = "some comment"
            
            return cell
            
        default:
            fatalError("Unexpected row")
        }
        
        
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
