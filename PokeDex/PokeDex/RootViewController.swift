//
//  RootViewController.swift
//  PokeDex
//
//  Created by Infinum on 09/07/16.
//  Copyright © 2016 Infinum. All rights reserved.
//

import UIKit

import MBProgressHUD
import Alamofire
import Unbox

class RootViewController: UIViewController, LoadUser, StoreUser {

    var passwordTextField: UITextField!
    var usernameTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        loadFromUserDefaults()
        self.navigationController?.navigationBarHidden = true
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 60
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView.allowsSelection = false
    }

    override func viewWillDisappear(animated: Bool)
    {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBarHidden = false
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    }
    
    func loadFromUserDefaults() {

        if let loadedUser = loadUser(){
            let user = User(authToken: loadedUser.token, email: loadedUser.email, username: loadedUser.username)
            didAddUser(user)
        }
        
    }
    
    @IBAction func logInButtonClick(sender: UIButton) {
        
        let username = usernameTextField.text
        let password = passwordTextField.text
        
        userLogin(username!, password: password!, nextViewController: self)

    }

    @IBAction func signUpButtonClick(sender: AnyObject) {
        
        let viewController = storyboard?.instantiateViewControllerWithIdentifier("signup") as! RegistrationViewController
        viewController.rootViewController = self
        navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    @IBAction func visibilityButtonClick(sender: AnyObject) {
        
        if passwordTextField.secureTextEntry{
            passwordTextField.font = nil
            passwordTextField.font = UIFont.systemFontOfSize(20.0)
        }
        
        passwordTextField.secureTextEntry = !passwordTextField.secureTextEntry
    }

}

extension RootViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("editText") as! EditTextWithImageTableViewCell
        

        switch indexPath.row {
        case 0:

            cell.textView.placeholder = "E-mail"
            usernameTextField = cell.textView
            
            cell.infoImage.image = UIImage(named:"icon_email")
            
        case 1:
            
            cell.textView.placeholder = "Password"
            cell.textView.secureTextEntry = true
            passwordTextField = cell.textView
            
            cell.infoImage.image = UIImage(named:"icon_password")
            
            let image = UIImage(named: "icon_visibility") as UIImage?
            cell.rightButton.setImage(image, forState: .Normal)
            cell.rightButton.addTarget(self, action: #selector(RootViewController.visibilityButtonClick(_:)), forControlEvents:.TouchUpInside)
            
        default:
            fatalError("Unexpected row")
        }
        
        return cell
    }
    
}


extension RootViewController: UserAdded {
    
    func didAddUser(user: User) {
        
        let homeViewController = self.storyboard?.instantiateViewControllerWithIdentifier("home") as! HomeViewController
        homeViewController.user = user
        storeUser(user)
        homeViewController.getPokemons(user.authorization)
        navigationController?.pushViewController(homeViewController, animated: true)
    }
}


extension RootViewController: Login {
    
    func userLogin(username: String, password: String, nextViewController: UserAdded){
        
        let parameters = ["password": password, "email": username]
        let data = ["type": "session", "attributes": parameters]
        let params = ["data": data]
        
        MBProgressHUD.showHUDAddedTo(view, animated: true)
        
        Alamofire.request(.POST, "https://pokeapi.infinum.co/api/v1/users/login", parameters: params, encoding: .JSON).validate().responseJSON
            { (response) in
                
                MBProgressHUD.hideHUDForView(self.view, animated: true)
                
                switch response.result {
                case .Success:
                    print("Validation Successful")
                    print("\(response)")
                    do {
                        let data = response.data!
                        let user: User = try Unbox(data)
                        
                        nextViewController.didAddUser(user)
                        
                        print("\(user)")
                        //self.login(user)
                    } catch _ {
                        print("Failed")
                    }
                case .Failure(let error):
                    print(error)
                }
        }
        
    }
}