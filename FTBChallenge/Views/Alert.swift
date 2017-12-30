//
//  Alert.swift
//  FTBChallenge
//
//  Created by Alejandro on 30/12/2017.
//  Copyright © 2017 Alejandro. All rights reserved.
//

import Foundation
import UIKit

func showAlert(on: UIViewController, title: String, message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
    alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.default, handler: nil))
    
    DispatchQueue.main.async {
        on.present(alert, animated: true, completion: nil)
    }
}
