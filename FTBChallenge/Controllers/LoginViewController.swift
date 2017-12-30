//
//  LoginViewController.swift
//  FTBChallenge
//
//  Created by Alejandro on 21/12/2017.
//  Copyright © 2017 Alejandro. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    public static let previousSessionKey = "previousSession"
    
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
                self.saveSession()
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
    
    private func validateUserName(userName: String) -> Bool {
        if (userName.isEmpty) {
            showAlert(on: self, title: "Usuario vacío", message: "Introduzca nombre de usuario")
            return false
        }
        
        return true
    }
    
    private func validatePassword(password: String) -> Bool {
        if (password.isEmpty) {
            showAlert(on: self, title: "Contraseña vacía", message: "Introduzca contraseña")
            return false
        }
        
        return true
    }
    
    private func saveSession() {
        let userDefaults = UserDefaults.standard
        userDefaults.set(true, forKey: LoginViewController.previousSessionKey)
    }
}
