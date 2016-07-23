//
//  PokemonList.swift
//  PokeDex
//
//  Created by Infinum on 23/07/16.
//  Copyright © 2016 Infinum. All rights reserved.
//

import Foundation

import Unbox

struct PokemonList: Unboxable {
    
    let pokemons: [Pokemon]
    
    init(unboxer: Unboxer) {
        pokemons = unboxer.unbox("data")
    }
}
