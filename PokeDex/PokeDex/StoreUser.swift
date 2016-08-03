//
//  StoreUser.swift
//  PokeDex
//
//  Created by Infinum on 03/08/16.
//  Copyright © 2016 Infinum. All rights reserved.
//

import Foundation
import UIKit

protocol StoreUser {
    
    func storeUser(user: User)
}

extension StoreUser where Self:  UIViewController {

    func storeUser(user: User){
    
        NSUserDefaults.standardUserDefaults().setObject(user.authToken, forKey:"auth-token")
        NSUserDefaults.standardUserDefaults().setObject(user.email, forKey:"email")
        NSUserDefaults.standardUserDefaults().setObject(user.username, forKey:"username")
        
    }
}