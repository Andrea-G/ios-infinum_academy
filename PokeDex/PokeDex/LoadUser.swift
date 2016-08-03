//
//  LoadUser.swift
//  PokeDex
//
//  Created by Infinum on 03/08/16.
//  Copyright © 2016 Infinum. All rights reserved.
//

import Foundation
import UIKit

protocol LoadUser {
    
    func loadUser() -> (email: String, username: String, token: String)?
}

extension LoadUser where Self:  UIViewController {
    
    func loadUser() -> (email: String, username: String, token: String)? {
        
        let ud = NSUserDefaults.standardUserDefaults()
        
        if let email = ud.stringForKey("email"){
            
            if let username = ud.stringForKey("username"){
                
                if let token = ud.stringForKey("auth-token"){
                    return (email, username, token)
                } else {
                    return nil
                }
                
            } else {
                return nil
            }
        } else {
            return nil
        }

    }
}