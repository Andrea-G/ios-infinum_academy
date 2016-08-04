//
//  RegistrationViewController.swift
//  PokeDex
//
//  Created by Infinum on 19/07/16.
//  Copyright © 2016 Infinum. All rights reserved.
//

import UIKit

import Alamofire
import Unbox
import MBProgressHUD

class RegistrationViewController: UIViewController, Signup {

    
    weak var confirmPasswordTextField: UITextField!
    weak var passwordTextField: UITextField!
    weak var emailTextField: UITextField!
    weak var nicknameTextField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    weak var rootViewController : UserAdded?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Sign Up"
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 60
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView.allowsSelection = false

    }
    
    @IBAction func signUpButtonClick(sender: AnyObject) {
        
        let username = nicknameTextField.text
        let password = passwordTextField.text
        let email = emailTextField.text
        let passwordConfirmation = confirmPasswordTextField.text
        
        userSignup(username!, password: password!, email: email!, passwordConfirmation : passwordConfirmation!, nextViewController: rootViewController!)
    }

}

extension RegistrationViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("editText") as! EditTextWithImageTableViewCell
        
        
        switch indexPath.row {
        case 0:
            
            cell.textView.placeholder = "E-mail"
            emailTextField = cell.textView
            
            cell.infoImage.image = UIImage(named:"icon_email")
            
        case 1:
            
            cell.textView.placeholder = "Nickname"
            nicknameTextField = cell.textView
            
            cell.infoImage.image = UIImage(named:"icon_person")
            
        case 2:
            
            cell.textView.placeholder = "Password"
            cell.textView.secureTextEntry = true
            passwordTextField = cell.textView
            
            cell.infoImage.image = UIImage(named:"icon_password")
            
        case 3:
            
            cell.textView.placeholder = "Confirm password"
            cell.textView.secureTextEntry = true
            confirmPasswordTextField = cell.textView
            
            cell.infoImage.image = UIImage(named:"icon_password")
            
        default:
            fatalError("Unexpected row")
        }
        
        return cell
    }
    
}

