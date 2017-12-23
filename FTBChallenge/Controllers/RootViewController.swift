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
        navigationController?.pushViewController(PlayersViewController(), animated: true)
    }
    
    @IBAction func emptyCache(_ sender: Any) {
    }
    
    @IBAction func closeSession(_ sender: Any) {
    }
    
}
