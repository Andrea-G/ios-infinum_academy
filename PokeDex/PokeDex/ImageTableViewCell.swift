//
//  ImageTableViewCell.swift
//  PokeDex
//
//  Created by Infinum on 10/08/16.
//  Copyright © 2016 Infinum. All rights reserved.
//

import UIKit

class ImageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var img: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
