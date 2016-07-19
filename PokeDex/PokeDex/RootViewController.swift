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

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logInButtonClick(sender: UIButton) {
        
        //print(usernameTextField.text)
        //print(passwordTextField.text)
        
        let username = usernameTextField.text
        let password = passwordTextField.text
        
        let parameters = ["password": password!, "email": username!]
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
        
        let viewController = storyboard?.instantiateViewControllerWithIdentifier("home") as! HomeViewController
        viewController.user = user
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
