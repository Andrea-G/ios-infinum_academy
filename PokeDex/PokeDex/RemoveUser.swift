//
//  RemoveUser.swift
//  PokeDex
//
//  Created by Infinum on 03/08/16.
//  Copyright © 2016 Infinum. All rights reserved.
//

import Foundation
import UIKit

protocol RemoveUser {
    
    func removeUser()
}

extension RemoveUser where Self:  UIViewController {
    
    func removeUser(){
        
        NSUserDefaults.standardUserDefaults().removeObjectForKey("auth-token")
        NSUserDefaults.standardUserDefaults().removeObjectForKey("email")
        NSUserDefaults.standardUserDefaults().removeObjectForKey("username")
        
    }
}