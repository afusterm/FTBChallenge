//
//  UIViewController+Background.swift
//  FTBChallenge
//
//  Created by Alejandro on 30/12/2017.
//  Copyright © 2017 Alejandro. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func backgroundImage(named: String) {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: named)
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        view.insertSubview(backgroundImage, at: 0)
    }
}
