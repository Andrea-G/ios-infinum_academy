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
    
    let id: String?
    
    let name: String?
    let baseExperience: Int?
    let isDefault: Bool?
    let order: Int?
    let height: Double?
    let weight: Double?
    let createdAt: String?
    let updatedAt: String?
    let imageUrl: String?
    let description: String?
    let totalVoteCount: Int?
    
    let gender: String?
    
    init(unboxer: Unboxer) {
        
        id = unboxer.unbox("id")
        
        name = unboxer.unbox("attributes.name")
        baseExperience = unboxer.unbox("attributes.base-experience")
        isDefault = unboxer.unbox("attributes.is-default")
        order = unboxer.unbox("attributes.order")
        height = unboxer.unbox("attributes.height")
        weight = unboxer.unbox("attributes.weight")
        createdAt = unboxer.unbox("attributes.created-at")
        updatedAt = unboxer.unbox("attributes.updated-at")
        imageUrl = unboxer.unbox("attributes.image-url")
        description = unboxer.unbox("attributes.description")
        totalVoteCount = unboxer.unbox("attributes.total-vote-count")
        
        gender = "M"
    }
}
