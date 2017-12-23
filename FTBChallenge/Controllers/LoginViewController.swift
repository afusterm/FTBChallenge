//
//  LoginViewController.swift
//  FTBChallenge
//
//  Created by Alejandro on 21/12/2017.
//  Copyright © 2017 Alejandro. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var userEntry: UITextField!
    @IBOutlet weak var passwordEntry: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Actions
    
    @IBAction func doLogin(_ sender: Any) {
        let loginInteractor = LoginInteractor()
        let userName = userEntry.text!
        let password = passwordEntry.text!
        
        if (!validateUserName(userName: userName)) {
            return
        }
        
        if (!validatePassword(password: password)) {
            return
        }
        
        loginInteractor.login(userName: userName, password: password, closure: {(isValid: Bool, message: String?) -> Void in
            if (isValid) {
                let rootVC = RootViewController()
                self.navigationController?.pushViewController(rootVC, animated: true)
            }
        })
    }
    
    // MARK: Helper methods
    
    func validateUserName(userName: String) -> Bool {
        if (userName.isEmpty) {
            showAlert(title: "Usuario vacío", message: "Introduzca nombre de usuario")
            return false
        }
        
        return true
    }
    
    func validatePassword(password: String) -> Bool {
        if (password.isEmpty) {
            showAlert(title: "Contraseña vacía", message: "Introduzca contraseña")
            return false
        }
        
        return true
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
