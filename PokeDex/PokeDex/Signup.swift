//
//  Signup.swift
//  PokeDex
//
//  Created by Infinum on 03/08/16.
//  Copyright © 2016 Infinum. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD
import Alamofire
import Unbox

protocol Signup {
    
    func userSignup(username: String, password: String, email : String, passwordConfirmation : String, nextViewController: UserAdded)
}

extension Signup where Self: UIViewController {
    
    func userSignup(username: String, password: String, email : String, passwordConfirmation : String, nextViewController: UserAdded){
        
        let parameters = ["username": username, "password": password, "email": email, "password_confirmation": passwordConfirmation]
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
                            nextViewController.didAddUser(user)
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
