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

    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nicknameTextField: UITextField!
    
    weak var rootViewController : UserAdded?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Sign Up"

    }
    
    @IBAction func signUpButtonClick(sender: AnyObject) {
        
        let username = nicknameTextField.text
        let password = passwordTextField.text
        let email = emailTextField.text
        let passwordConfirmation = confirmPasswordTextField.text
        
        userSignup(username!, password: password!, email: email!, passwordConfirmation : passwordConfirmation!, nextViewController: rootViewController!)
    }

}
