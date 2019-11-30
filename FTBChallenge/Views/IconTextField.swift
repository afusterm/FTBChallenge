//
//  IconTextView.swift
//  FTBChallenge
//
//  Created by Alejandro on 10/01/2018.
//  Copyright © 2018 Alejandro. All rights reserved.
//

import UIKit

@IBDesignable
class IconTextField: UITextField {
    private var imageView: UIImageView?
    
    @IBInspectable var rightImage: UIImage? {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var rightPadding: CGFloat = 0 {
        didSet {
            updateView()
        }
    }
    
    private func updateView() {
        if let image = rightImage {
            rightViewMode = .always
            imageView = UIImageView(frame: CGRect(x: -rightPadding, y: 0, width: 20, height: 20))
            imageView?.image = image
            imageView?.isUserInteractionEnabled = true
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
            imageView?.addGestureRecognizer(tapGestureRecognizer)
            
            let width = rightPadding + 20
            
            let view = UIView(frame: CGRect(x: -rightPadding, y: 0, width: width, height: 20))
            
            view.addSubview(imageView!)
            
            rightView = view
        } else {
            rightViewMode = .never
        }
    }
    
    @objc private func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        self.isSecureTextEntry = !self.isSecureTextEntry
    }
}
