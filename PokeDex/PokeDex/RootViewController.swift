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

class RootViewController: UIViewController, Login, LoadUser, StoreUser {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        loadFromUserDefaults()
        self.navigationController?.navigationBarHidden = true

        // Do any additional setup after loading the view.
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
        navigationController?.pushViewController(viewController, animated: true)
        
    }

}


extension RootViewController: UserAdded {
    
    func didAddUser(user: User) {
        
        let homeViewController = self.storyboard?.instantiateViewControllerWithIdentifier("home") as! HomeViewController
        homeViewController.user = user
        storeUser(user)
        homeViewController.getPokemons()
        navigationController?.pushViewController(homeViewController, animated: true)
    }
}