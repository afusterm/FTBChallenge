//
//  MyAccountViewController.swift
//  FTBChallenge
//
//  Created by Alejandro on 21/12/2017.
//  Copyright © 2017 Alejandro. All rights reserved.
//

import UIKit

class MyAccountViewController: UIViewController {

    @IBOutlet weak var accountImageView: UIImageView!
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var phoneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundImage(named: "background_login.jpg")
        navigationController?.isNavigationBarHidden = false
        setupImageView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func setupImageView() {
        accountImageView.layer.cornerRadius = accountImageView.frame.size.width / 2
        accountImageView.clipsToBounds = true
        accountImageView.layer.borderWidth = 3.0
        accountImageView.layer.borderColor = UIColor.white.cgColor
    }
    
    // MARK: Actions
    
    @IBAction func openMail(_ sender: Any) {
        let email = emailButton.currentTitle!
        if let url = URL(string: "mailto:\(email)") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func callToPhone(_ sender: Any) {
        let phoneNumber = phoneButton.currentTitle!
        if let url = URL(string: "tel://\(phoneNumber)") {
            UIApplication.shared.open(url, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
        }
    }
    
    @IBAction func openLinkedin(_ sender: Any) {
        let link = "in/alejandrofusterm/"
        if let url = URL(string: "linkedin://\(link)") {
            UIApplication.shared.open(url, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: { (opened) in
                if (!opened) {
                    self.openLinkedinWeb(link: link)
                }
            })
        }
    }
    
    private func openLinkedinWeb(link: String) {
        if let url = URL(string: "https://linkedin.com/\(link)") {
            UIApplication.shared.open(url, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
        }
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}
