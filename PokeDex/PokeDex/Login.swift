//
//  Login.swift
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

protocol Login {
    
    func userLogin(username: String, password: String, nextViewController: UserAdded)
}

extension Login where Self: UIViewController {
    
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
