//
//  PokemonGeneralDetailsTableViewCell.swift
//  PokeDex
//
//  Copyright © 2016 Infinum. All rights reserved.
//

import UIKit

class PokemonGeneralDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonInfoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
