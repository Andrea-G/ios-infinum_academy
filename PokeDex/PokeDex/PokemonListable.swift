//
//  PokemonListable.swift
//  PokeDex
//
//  Created by Infinum on 03/08/16.
//  Copyright © 2016 Infinum. All rights reserved.
//

import Foundation

protocol PokemonListable: class {
    
    func addPokemons(pokemons: [Pokemon])
}