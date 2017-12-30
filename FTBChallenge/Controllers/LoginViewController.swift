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
        userEntry.text = "ftbchallenge"
        passwordEntry.text = "challengeFTB2017"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Actions
    
    @IBAction func doLogin(_ sender: Any) {
        let userName = userEntry.text!
        let password = passwordEntry.text!
        
        if (!validateUserName(userName: userName)) {
            return
        }
        
        if (!validatePassword(password: password)) {
            return
        }
        
        let userInfo = LoginInfo(user: userName, password: password)
        let loginInteractor = LoginInteractor()
        loginInteractor.login(info: userInfo, closure: {(isValid: Bool, message: String?) -> Void in
            if (isValid) {
                DispatchQueue.main.async {
                    let rootVC = RootViewController()
                    rootVC.navigationItem.hidesBackButton = true
                    self.navigationController?.pushViewController(rootVC, animated: true)
                }
            } else {
                showAlert(on: self, title: "Error en login", message: message!)
            }
        })
    }
    
    // MARK: Helper methods
    
    func validateUserName(userName: String) -> Bool {
        if (userName.isEmpty) {
            showAlert(on: self, title: "Usuario vacío", message: "Introduzca nombre de usuario")
            return false
        }
        
        return true
    }
    
    func validatePassword(password: String) -> Bool {
        if (password.isEmpty) {
            showAlert(on: self, title: "Contraseña vacía", message: "Introduzca contraseña")
            return false
        }
        
        return true
    }
    /* XXX
    func showAlert(title: String, message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }*/
}
