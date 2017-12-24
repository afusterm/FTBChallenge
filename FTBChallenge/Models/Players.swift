//
//  Players.swift
//  FTBChallenge
//
//  Created by Alejandro on 24/12/2017.
//  Copyright © 2017 Alejandro. All rights reserved.
//

import Foundation

class Players {
    private var players = [Player]()
    
    func add(player: Player) {
        players.append(player)
    }
    
    var count: Int {
        return players.count
    }
    
    func get(position: Int) -> Player {
        return players[position]
    }
}
