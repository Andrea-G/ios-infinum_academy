//
//  CommentAddedDelegate.swift
//  PokeDex
//
//  Created by Infinum on 11/08/16.
//  Copyright © 2016 Infinum. All rights reserved.
//

import Foundation

protocol CommentAddedDelegate: class {
    
    func didAddComment(comment: String)
}