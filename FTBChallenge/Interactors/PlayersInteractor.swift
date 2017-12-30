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
    private var requester: HttpRequester
    
    init(requester: HttpRequester = URLSession(configuration: URLSessionConfiguration.default)) {
        self.requester = requester
    }
    
    func downloadSignings(closure: @escaping (_: Players) -> Void) {
        var request = URLRequest(url: URL(string: signingsUrl)!)
        request.httpMethod = "POST"
        requester.data(request: request) { (data) in
            let dictionary = try? JSONSerialization.jsonObject(with: data, options: [])
            if let dict = dictionary as? JSONDictionary {
                let playersDecoded = self.decodePlayersResponse(response: dict)
                closure(playersDecoded)
            }
        }
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
