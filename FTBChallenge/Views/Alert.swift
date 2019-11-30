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
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil))
    
    DispatchQueue.main.async {
        on.present(alert, animated: true, completion: nil)
    }
}
