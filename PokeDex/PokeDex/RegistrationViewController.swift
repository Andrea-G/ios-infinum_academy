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

class RegistrationViewController: UIViewController {

    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nicknameTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Sign Up"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signUpButtonClick(sender: AnyObject) {
        
        
        let username = nicknameTextField.text
        let password = passwordTextField.text
        let email = emailTextField.text
        let password_confirmation = confirmPasswordTextField.text
        
        let parameters = ["username": username!, "password": password!, "email": email!, "password_confirmation": password_confirmation!]
        let data = ["type": "users", "attributes": parameters]
        let params = ["data": data]
        
        MBProgressHUD.showHUDAddedTo(view, animated: true)
        
        Alamofire.request(.POST, "https://pokeapi.infinum.co/api/v1/users", parameters: params, encoding: .JSON).validate().responseJSON
            { (response) in

                MBProgressHUD.hideHUDForView(self.view, animated: true)
                switch response.result {
                case .Success:
                    print("Validation Successful")
                    print("\(response)")
                    do {
                        if let data = response.data {
                            let user: User = try Unbox(data)
                            print("\(user)")
                            
                            self.getPokemons(user)
                        }
                        
                    } catch _ {
                        print("Failed")
                    }
                case .Failure(let error):
                    print(error)
                }
        }
        
    }

}

extension RegistrationViewController: PokemonGettable {

}
