//
//  PokemonAddedDelegate.swift
//  PokeDex
//
//  Created by Infinum on 02/08/16.
//  Copyright © 2016 Infinum. All rights reserved.
//

import Foundation

protocol PokemonAddedDelegate: class {
    func didAddPokemon(name: String)
}