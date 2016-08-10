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
        
        guard let email = ud.stringForKey("email") else {
            return nil
        }
        
        guard let username = ud.stringForKey("username") else {
            return nil
        }
        
        guard let token = ud.stringForKey("auth-token") else {
            return nil
        }
        
        return (email, username, token)

    }
}