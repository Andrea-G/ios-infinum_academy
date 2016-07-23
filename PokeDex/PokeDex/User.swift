//
//  User.swift
//  PokeDex
//
//  Created by Infinum on 19/07/16.
//  Copyright © 2016 Infinum. All rights reserved.
//

import Foundation

import Unbox

struct User: Unboxable {
    let authToken: String
    let email: String
    let username: String
    
    init(unboxer: Unboxer) {
        authToken = unboxer.unbox("data.attributes.auth-token")
        email = unboxer.unbox("data.attributes.email")
        username = unboxer.unbox("data.attributes.username")
    }
}