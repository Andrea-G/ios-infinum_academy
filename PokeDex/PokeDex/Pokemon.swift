//
//  Pokemon.swift
//  PokeDex
//
//  Created by Infinum on 23/07/16.
//  Copyright © 2016 Infinum. All rights reserved.
//

import Foundation

import Unbox

struct Pokemon: Unboxable {
    
    let name: String?
    let baseExperience: Int?
    let isDefault: Bool?
    let order: Int?
    let height: Double?
    let weight: String?
    let createdAt: String?
    let updatedAt: String?
    let imageUrl: String?
    let description: String?
    let totalVoteCount: Int?
    
    let gender: String?
    
    init(unboxer: Unboxer) {
        
        name = unboxer.unbox("attributes.name")
        baseExperience = unboxer.unbox("base-experience")
        isDefault = unboxer.unbox("is-default")
        order = unboxer.unbox("order")
        height = unboxer.unbox("height")
        weight = unboxer.unbox("weight")
        createdAt = unboxer.unbox("created-at")
        updatedAt = unboxer.unbox("updated-at")
        imageUrl = unboxer.unbox("image-url")
        description = unboxer.unbox("description")
        totalVoteCount = unboxer.unbox("total-vote-count")
        
        gender = "M"
    }
}
