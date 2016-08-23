//
//  AddPokemonTableViewCell.swift
//  PokeDex
//
//  Created by Infinum on 01/08/16.
//  Copyright © 2016 Infinum. All rights reserved.
//

import UIKit

class AddPokemonTableViewCell: UITableViewCell {

    @IBOutlet weak var infoImage: UIImageView!
    @IBOutlet weak var textView: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
