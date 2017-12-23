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
        // TODO: make a guard and show error message if user and password are not filled
        /* XXX
        guard let userName = userEntry.text else {
            print("Usuario vacio")
            return
        }*/
        
        let userName = userEntry.text!
        
        if (userName.isEmpty) {
            print("Usuario vacio")
            return
        }
        
        guard let password = passwordEntry.text else {
            print("Contraseña vacía")
            return
        }
        
        loginInteractor.login(userName: userName, password: password, closure: {(isValid: Bool, message: String?) -> Void in
            if (isValid) {
                let rootVC = RootViewController()
                self.navigationController?.pushViewController(rootVC, animated: true)
            }
        })
    }
}
