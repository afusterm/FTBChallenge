//
//  PlayerCell2.swift
//  FTBChallenge
//
//  Created by Alejandro on 01/01/2018.
//  Copyright © 2018 Alejandro. All rights reserved.
//

import Foundation
import UIKit

class PlayerCell: UICollectionViewCell {
    private var backgroundImage: UIImageView!
    private var playerImageView: UIImageView!
    private var nameLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupBackground()
        setupPlayerLabel()
        setupPlayerImage()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBackground() {
        let image = UIImage(named: "celda-player.png")
        backgroundImage = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        backgroundImage.contentMode = .scaleAspectFit
        backgroundImage.image = image
        contentView.addSubview(backgroundImage)
    }
    
    private func setupPlayerLabel() {
        nameLabel = UILabel(frame: CGRect(x: frame.width / 2, y: 5, width: frame.width / 2 - 5,
                                          height: frame.height / 2))
        nameLabel.font = UIFont.systemFont(ofSize: CGFloat(14), weight: UIFont.Weight.bold)
        nameLabel.textAlignment = .left
        nameLabel.lineBreakMode = .byWordWrapping
        nameLabel.numberOfLines = 2
        nameLabel.textColor = UIColor.white
        contentView.addSubview(nameLabel)
    }
    
    private func setupPlayerImage() {
        playerImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width / 2, height: frame.size.height))
        playerImageView.contentMode = .scaleAspectFit
        contentView.addSubview(playerImageView)
    }
    
    // MARK: Properties
    
    var name: String? {
        get {
            return nameLabel.text
        }
        set(value) {
            nameLabel.text = value
        }
    }
    
    var image: UIImage? {
        get {
            return playerImageView.image
        }
        set(value) {
            playerImageView.image = value
        }
    }
}
