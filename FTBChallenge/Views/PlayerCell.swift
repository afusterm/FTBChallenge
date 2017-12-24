//
//  PlayersCollectionViewCell.swift
//  FTBChallenge
//
//  Created by Alejandro on 24/12/2017.
//  Copyright © 2017 Alejandro. All rights reserved.
//

import UIKit

class PlayerCell: UICollectionViewCell {
    var textLabel: UILabel!
    var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let imageWidth = frame.size.width
        let imageHeight = imageWidth
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight))
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        backgroundColor = UIColor.black
        contentView.addSubview(imageView)
        
        let labelHeight = imageWidth / 2
        let labelWidth = imageWidth / 2
        textLabel = UILabel(frame: CGRect(x: labelWidth - 1, y: 2, width: labelWidth, height: labelHeight))
        textLabel.font = UIFont.boldSystemFont(ofSize: 22)
        textLabel.textColor = UIColor.white
        textLabel.textAlignment = .left
        contentView.addSubview(textLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
