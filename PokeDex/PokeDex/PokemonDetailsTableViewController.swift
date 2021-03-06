//
//  PokemonDetailsTableViewController.swift
//  PokeDex
//
//  Copyright © 2016 Infinum. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
import Unbox
import Kingfisher

class PokemonDetailsTableViewController: UITableViewController {
    
    var pokemon: Pokemon!
    var user: User!
    var comments = [Comment]()
    var usernameDictionary = [String: String]()
    var commentTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = pokemon.name
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView.allowsSelection = false
        refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(PokemonDetailsTableViewController.handleRefresh(_:)), forControlEvents: UIControlEvents.ValueChanged)

    }
    
    func handleRefresh(refreshControl: UIRefreshControl) {
        getComments(user.authorization)
    }

    // MARK: - Table view data source


    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 8 + comments.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var commentsRange = 7
        if comments.count != 0 {
            commentsRange = 7 + comments.count - 1
        }
        
        switch indexPath.row {
            
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("pokeImage") as! ImageTableViewCell
            
            if let imageUrl = pokemon.imageUrl {
                let url:NSURL = NSURL(string: "https://pokeapi.infinum.co" + imageUrl)!
                cell.img.kf_setImageWithURL(url, placeholderImage: UIImage(named: "image_placeholder"))
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
            
        case 7...commentsRange:
            
            if comments.count == 0 {
                fallthrough
            }
            let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("comment") as UITableViewCell!
            let id = comments[indexPath.row-7].userId!
            
            if let val = usernameDictionary[id] {
                cell.textLabel?.text = val
            }

            cell.detailTextLabel?.text = comments[indexPath.row-7].content
            
            return cell
            
        case (7+comments.count):
            let cell = tableView.dequeueReusableCellWithIdentifier("addComment") as UITableViewCell!
            
            let tap = UITapGestureRecognizer(target: self, action:#selector(PokemonDetailsTableViewController.addCommentClick))
            cell.textLabel?.addGestureRecognizer(tap)
            
            return cell
            
        default:
            fatalError("Unexpected row")
        }
        
    }
    
    func addCommentClick(){
        
        let vc = storyboard?.instantiateViewControllerWithIdentifier("commentPopup")  as! CommentPopupViewController
        vc.delegate = self
        vc.modalPresentationStyle = .OverCurrentContext
        navigationController?.presentViewController(vc, animated: true, completion: {
            
        })
    }
    
    func submitComment(comment: String, authorization: String){
        
        let parameters = ["content": comment]
        let data = ["attributes": parameters]
        let params = ["data": data]
        
        let headers = ["Authorization": authorization,]
        
        let id = pokemon.id!
        
        MBProgressHUD.showHUDAddedTo(view, animated: true)
        
        Alamofire.request(.POST, "https://pokeapi.infinum.co/api/v1/pokemons/" + id + "/comments", parameters: params, headers: headers, encoding: .JSON).validate().responseJSON
            { (response) in
                
                MBProgressHUD.hideHUDForView(self.view, animated: true)
                
                switch response.result {
                case .Success:
                    print("Validation Successful")
                    print("\(response)")
                    self.getComments(authorization)
                    
                case .Failure(let error):
                    print(error)
                }
        }

    }
    
}

extension PokemonDetailsTableViewController : CommentGettable {
    
    func getComments(authorization: String){
        
        let headers = ["Authorization": authorization,]
        MBProgressHUD.showHUDAddedTo(view, animated: true)
        
        let id = pokemon.id!
        
        Alamofire.request(.GET, "https://pokeapi.infinum.co/api/v1/pokemons/" + id + "/comments", headers: headers, encoding: .JSON).validate().responseJSON
            { (response) in
                
                MBProgressHUD.hideHUDForView(self.view, animated: true)
                switch response.result {
                case .Success:
                    print("Successful")
                    
                    do {
                        let data = response.data!
                        let commentList : CommentList = try Unbox(data)
                        
                        self.comments = commentList.comments
                        let ids = self.comments.map { $0.userId }
                        
                        ids.map{ self.getUser(authorization, id: $0!) }
                        
                        self.tableView.reloadData()
                        
                    } catch _ {
                        print("Failed")
                    }
                case .Failure(let error):
                    print(error)
                }
                if let rc = self.refreshControl {
                    if (rc.refreshing) {
                        rc.endRefreshing()
                    }
                }
        }
    }
}

extension PokemonDetailsTableViewController : CommentAddedDelegate {

    func didAddComment(comment: String) {
        
        submitComment(comment, authorization: user.authorization)

    }
}

extension PokemonDetailsTableViewController : GetUser {
    
    func getUser(authorization: String, id: String) {
        
        let headers = ["Authorization": authorization,]
        //MBProgressHUD.showHUDAddedTo(view, animated: true)
        
        Alamofire.request(.GET, "https://pokeapi.infinum.co/api/v1/users/" + id, headers: headers, encoding: .JSON).validate().responseJSON
            { (response) in
                
                //MBProgressHUD.hideHUDForView(self.view, animated: true)
                switch response.result {
                case .Success:
                    
                    do {
                        let data = response.data!
                        let user : CommentUser = try Unbox(data)
                        self.usernameDictionary[id] = user.username
                        
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