//
//  PlayersInteractor.swift
//  FTBChallenge
//
//  Created by Alejandro on 24/12/2017.
//  Copyright © 2017 Alejandro. All rights reserved.
//

import Foundation
import UIKit

class PlayersInteractor {
    func download(closure: (_: Players) -> Void){
        let players = Players()
        players.add(player: Player(name: "Ozil", image: UIImage(named: "ozil.png")))
        players.add(player: Player(name: "Iker Casillas", image: UIImage(named: "ozil.png")))
        players.add(player: Player(name: "Ronaldo", image: UIImage(named: "ozil.png")))
        players.add(player: Player(name: "Messi", image: UIImage(named: "ozil.png")))
        players.add(player: Player(name: "Isco", image: UIImage(named: "ozil.png")))
        players.add(player: Player(name: "Paco", image: UIImage(named: "ozil.png")))
        
        closure(players)
    }
}
