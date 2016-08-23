//
//  PokemonListTableViewCell.swift
//  PokeDex
//
//  Created by Infinum on 17/08/16.
//  Copyright © 2016 Infinum. All rights reserved.
//

import UIKit

class PokemonListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
