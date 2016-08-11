//
//  CommentList.swift
//  PokeDex
//
//  Created by Infinum on 11/08/16.
//  Copyright © 2016 Infinum. All rights reserved.
//

import Foundation

import Unbox

struct CommentList: Unboxable {
    
    let comments: [Comment]
    
    init(unboxer: Unboxer) {
        comments = unboxer.unbox("data")
    }
}