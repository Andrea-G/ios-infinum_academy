//
//  EditTextWithImageTableViewCell.swift
//  PokeDex
//
//  Created by Infinum on 04/08/16.
//  Copyright © 2016 Infinum. All rights reserved.
//

import UIKit

class EditTextWithImageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var infoImage: UIImageView!
    @IBOutlet weak var rightButton: UIButton!
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
