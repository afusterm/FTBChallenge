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
    private let signingsUrl = "http://ftbsports.com/ios/api/signings.php"
    
    func downloadSignings(closure: @escaping (_: Players) -> Void){
        post(parse: {(result) -> Void in
            let players = self.decodePlayersResponse(response: result)
            closure(players)
        })
        /* XXX
        let players = Players()
        players.add(player: Player(name: "Ozil", image: UIImage(named: "ozil.png")))
        players.add(player: Player(name: "Iker Casillas", image: UIImage(named: "ozil.png")))
        players.add(player: Player(name: "Ronaldo", image: UIImage(named: "ozil.png")))
        players.add(player: Player(name: "Messi", image: UIImage(named: "ozil.png")))
        players.add(player: Player(name: "Isco", image: UIImage(named: "ozil.png")))
        players.add(player: Player(name: "Paco", image: UIImage(named: "ozil.png")))
        
        closure(players)
        */
    }
    
    private func post(parse: @escaping (_ result: JSONDictionary) -> Void) {
        let session = URLSession.shared
        var request = URLRequest(url: URL(string: signingsUrl)!)
        request.httpMethod = "POST"
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if (error != nil) {
                print("Error PlayersInteractor.post: ", error.debugDescription)
                return
            }
            
            let dictionary = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
            if let dict = dictionary as? JSONDictionary {
                parse(dict)
            }
        }
        
        task.resume()
    }
    
    private func decodePlayersResponse(response: JSONDictionary) -> Players {
        let players = Players()
        
        if let playersArray = response["players"] as? JSONArray {
            for playerDict in playersArray {
                var player = Player()
                if let playerName = playerDict["nombre"] as? String {
                    player.name = playerName
                }
                
                if let imageUrl = playerDict["url"] as? String {
                    player.imageUrl = imageUrl
                }
                
                players.add(player: player)
            }
        }
        
        return players
    }
}
