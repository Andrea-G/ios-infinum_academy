//
//  Comment.swift
//  PokeDex
//
//  Created by Infinum on 11/08/16.
//  Copyright © 2016 Infinum. All rights reserved.
//

import Foundation

import Unbox
import Alamofire
import MBProgressHUD

struct Comment: Unboxable {
    
    let content: String?
    let userId: String?
    
    init(unboxer: Unboxer) {
        
        content = unboxer.unbox("attributes.content")
        userId = unboxer.unbox("relationships.author.data.id")
    }

}
