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

class RootViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    @IBAction func logInButtonClick(sender: UIButton) {
        
        //print(usernameTextField.text)
        //print(passwordTextField.text)
        
        //let username = usernameTextField.text
        //let password = passwordTextField.text
        
        let username = "andrea@mail.com"
        let password = "andrea123"
        
        //let parameters = ["password": password!, "email": username!]
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
                        print("\(user)")
                        self.login(user)
                    } catch _ {
                        print("Failed")
                    }
                case .Failure(let error):
                    print(error)
                }
        }

    }

    @IBAction func signUpButtonClick(sender: AnyObject) {
        
        let viewController = storyboard?.instantiateViewControllerWithIdentifier("signup") as! RegistrationViewController
        navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    func login(user: User) {
        
        getPokemons(user)
    }

}

extension RootViewController: PokemonGettable {
    
}
