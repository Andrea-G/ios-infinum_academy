//
//  AddPokemonViewController.swift
//  PokeDex
//
//  Created by Infinum on 01/08/16.
//  Copyright © 2016 Infinum. All rights reserved.
//

import UIKit

import Alamofire
import MBProgressHUD

class AddPokemonViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var user: User!
    
    weak var delegate: PokemonAddedDelegate?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var pokemonImage: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        
        self.title = "Add new Pokemon"

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80
        
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView.allowsSelection = false
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addImageButtonClick(sender: AnyObject) {
        
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        
        presentViewController(imagePicker, animated: true, completion: nil)
        
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
        
        uploadPokemon(name!, height: height!, weight: weight!, type: type, abilities: abilities, description: description)
        
    }
    
    func uploadPokemon(name: String, height: String, weight: String, type: String?, abilities: String?, description: String?){
        
        let headers = [
            "Authorization": user.authorization,
            ]
        
        let attributes = ["name": name, "height": height, "weight": weight, "order": "36", "is_default": "1", "gender_id": "1", "description": "Some pokemon"]
        
        
        Alamofire.upload(.POST, "https://pokeapi.infinum.co/api/v1/pokemons", headers: headers, multipartFormData: {
            multipartFormData in
            if let image = self.pokemonImage.image {
                if let imageData = UIImageJPEGRepresentation(image, 0.8) {
                    multipartFormData.appendBodyPart(data: imageData, name: "data[attributes][image]", fileName: "file.jpeg", mimeType: "image/jpeg")
                }
            }
            for (key, value) in attributes {
                multipartFormData.appendBodyPart(data: value.dataUsingEncoding(NSUTF8StringEncoding)!, name: "data[attributes][" + (key) + "]")
            }
            }, encodingCompletion: {
                encodingResult in
                switch encodingResult {
                case .Success(let upload, _, _):
                    upload.responseString(completionHandler: { (response) in
                        if let data = response.data {
                            print(String(data: data, encoding: NSUTF8StringEncoding))
                        }
                        print(response.response)
                        if let delegate = self.delegate {
                            delegate.didAddPokemon(name)
                        }
                    })
                    self.navigationController?.popViewControllerAnimated(true)
                    
                case .Failure(let encodingError):
                    print(encodingError)
                }
        })
    }
    
    // MARK: - UIImagePickerControllerDelegate Methods
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            pokemonImage.contentMode = .ScaleAspectFit
            pokemonImage.image = pickedImage
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
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
