//
//  RootViewController.swift
//  FTBChallenge
//
//  Created by Alejandro on 21/12/2017.
//  Copyright © 2017 Alejandro. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Actions
    
    @IBAction func goToMyAccount(_ sender: Any) {
        navigationController?.pushViewController(MyAccountViewController(), animated: true)
    }
    
    @IBAction func goToPlayers(_ sender: Any) {
        let playersInteractor = PlayersInteractor()
        playersInteractor.downloadSignings(closure: {(players: Players) -> Void in
            if (!self.validatePlayersAreNotEmpty(players: players)) {
                return
            }
            
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(PlayersViewController(players: players), animated: true)
            }
        })
    }
    
    @IBAction func emptyCache(_ sender: Any) {
    }
    
    @IBAction func closeSession(_ sender: Any) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(false, forKey: LoginViewController.previousSessionKey)
        
        let loginViewController = LoginViewController()
        loginViewController.navigationItem.hidesBackButton = true
        navigationController?.pushViewController(loginViewController, animated: true)
    }
    
    // MARK: Helpers
    
    private func validatePlayersAreNotEmpty(players: Players) -> Bool {
        if (players.count > 0) {
            return true
        }
        
        showAlert(on: self,
                  title: "Error",
                  message: "No se pudieron descargar jugadores. Vuelva a intentarlo más tarde")
        
        return false
    }
}
