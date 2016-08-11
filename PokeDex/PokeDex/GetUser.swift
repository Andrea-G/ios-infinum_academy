//
//  GetUser.swift
//  PokeDex
//
//  Created by Infinum on 11/08/16.
//  Copyright © 2016 Infinum. All rights reserved.
//

import Foundation

protocol GetUser {
    
    func getUser(authorization: String) -> User
}