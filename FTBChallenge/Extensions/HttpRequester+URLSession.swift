//
//  HttpRequester+URLSession.swift
//  FTBChallenge
//
//  Created by Alejandro on 29/12/2017.
//  Copyright © 2017 Alejandro. All rights reserved.
//

import Foundation

extension URLSession: HttpRequester {
    public func data(request: URLRequest, receive: @escaping (Data) -> Void) {
        let task = self.dataTask(with: request) { (data, response, error) in
            if let errorObject = error {
                print("Error en tarea: ", errorObject.localizedDescription)
            }
            
            if (data != nil) {
                receive(data!)
            }
        }
        
        task.resume()
    }
}
