//
//  RootViewController.swift
//  FTBChallenge
//
//  Created by Alejandro on 21/12/2017.
//  Copyright © 2017 Alejandro. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    @IBOutlet weak var myAccountButton: UIButton!
    
    var logoImage: UIImageView!
    var focusLeft: UIImageView!
    var focusRight: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundImage(named: "background_login.jpg")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        startAnimation()
        startLightFocusAnimation()
    }
    
    override func viewDidLayoutSubviews() {
        setupLogoImage()
        setupFocusLeftImage()
        setupFocusRightImage()
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
        let imageCache = ImageCache.shared
        imageCache.empty()
        showAlert(on: self, title: "Vaciar caché", message: "Se ha vaciado la cache de imagenes")
    }
    
    @IBAction func closeSession(_ sender: Any) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(false, forKey: LoginViewController.previousSessionKey)
        
        let loginViewController = LoginViewController()
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
    
    // MARK: Properties
    
    let focusXMultiplier = CGFloat(0.18)
    let focusWidthMultiplier = CGFloat(0.33)
    let focusHeightMultiplier = CGFloat(0.2)
    
    var focusLeftInitialPoint: CGPoint {
        return CGPoint(x: view.bounds.width * (-focusXMultiplier), y: 90)
    }
    
    var focusLeftFinalPoint: CGPoint {
        return CGPoint(x: view.bounds.width * focusXMultiplier, y: 90)
    }
    
    var focusRightInitialPoint: CGPoint {
        return CGPoint(x: view.bounds.width + view.bounds.width * focusXMultiplier, y: 90)
    }
    
    var focusRightFinalPoint: CGPoint {
        return CGPoint(x: view.bounds.width + view.bounds.width * (-focusXMultiplier), y: 90)
    }
    
    var focusSize: CGSize {
        return CGSize(width: view.bounds.width * (-focusWidthMultiplier), height: view.bounds.height * focusHeightMultiplier)
    }
    
    // MARK: Animations
    
    private func setupLogoImage() {
        let initialPoint = CGPoint(x: myAccountButton.center.x, y: -220)
        let size = CGSize(width: view.bounds.width * 0.5, height: view.bounds.height * 0.4)
        let image = UIImage(named: "logo_ftb.png")
        
        logoImage = UIImageView(image: image)
        logoImage.contentMode = .scaleAspectFill
        logoImage.bounds = CGRect(origin: initialPoint, size: size)
        logoImage.center = initialPoint
        view.addSubview(logoImage)
    }
    
    private func setupFocusLeftImage() {
        let leftImage = UIImage(named: "lateral_izq.png")
        focusLeft =  UIImageView(image: leftImage)
        focusLeft.contentMode = .scaleAspectFill
        focusLeft.bounds = CGRect(origin: focusLeftInitialPoint, size: focusSize)
        focusLeft.center = focusLeftInitialPoint
        view.addSubview(focusLeft)
    }
    
    private func setupFocusRightImage() {
        let rightImage = UIImage(named: "lateral_der.png")
        focusRight =  UIImageView(image: rightImage)
        focusRight.contentMode = .scaleAspectFill
        focusRight.bounds = CGRect(origin: focusRightInitialPoint, size: focusSize)
        focusRight.center = focusRightInitialPoint
        view.addSubview(focusRight)
    }
 
    private func startAnimation() {
        let finalY = CGFloat(myAccountButton.center.y - logoImage.bounds.height / 2 - myAccountButton.bounds.height)
        let initialPoint = CGPoint(x: myAccountButton.center.x, y: -220)
        let finalPoint = CGPoint(x: myAccountButton.center.x, y: finalY)
        
        UIImageView.animate(withDuration: 1.5,
                            animations: {
                                self.logoImage.center = finalPoint
        }) { (finished) in
            if (finished) {
                self.logoImage.center = initialPoint
                self.startLightFocusAnimation()
                self.startAnimation()
            }
        }
    }
    
    private func startLightFocusAnimation() {
        UIImageView.animate(withDuration: 1.5,
                            animations: {
                                self.focusLeft.center = self.focusLeftFinalPoint
                                self.focusRight.center = self.focusRightFinalPoint
        }) { (_) in
            self.focusLeft.center = self.focusLeftInitialPoint
            self.focusRight.center = self.focusRightInitialPoint
        }
    }
}
