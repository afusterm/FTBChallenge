//
//  PlayerCell.swift
//  FTBChallenge
//
//  Created by Alejandro on 23/12/2017.
//  Copyright © 2017 Alejandro. All rights reserved.
//

import UIKit

class PlayerCell: UICollectionViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var name: String {
        get {
            return nameLabel.text!
        }
        set(text) {
            nameLabel.text = text
        }
    }
}
