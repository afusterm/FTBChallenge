//
//  LoginInteractor.swift
//  FTBChallenge
//
//  Created by Alejandro on 22/12/2017.
//  Copyright © 2017 Alejandro. All rights reserved.
//

import Foundation

typealias JSONObject = AnyObject
typealias JSONDictionary = [String: JSONObject]
typealias JSONArray = [JSONDictionary]

struct LoginResponse {
    var isValid: Bool
    var message: String
    
    init() {
        isValid = false
        message = ""
    }
}

class LoginInteractor {
    private let loginUrl = "http://ftbsports.com/ios/api/login.php"
    
    func login(userName: String, password: String, closure: @escaping (_ isValid: Bool, _ message: String?) -> Void) {
        post(user: userName, password: password, parse: {(result) -> Void in
            let loginResponse = self.decodeLoginResponse(response: result)
            closure(loginResponse.isValid, loginResponse.message)
        })
    }
    
    private func post(user: String, password: String, parse: @escaping (_ result: JSONDictionary) -> Void) {
        let session = URLSession.shared
        var request = URLRequest(url: URL(string: loginUrl)!)
        let params = "user=\(user)&password=\(password)"
        request.httpMethod = "POST"
        request.httpBody = params.data(using: .utf8)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if let errorObject = error {
                print("Error en tarea: ", errorObject.localizedDescription)
            }
            
            let dictionary = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
            if let dict = dictionary as? JSONDictionary {
                parse(dict)
            }
        }
        
        task.resume()
    }
    
    private func decodeLoginResponse(response: JSONDictionary) -> LoginResponse {
        var loginResponse = LoginResponse()
        if let status = response["status"] as? Int {
            if (status == 0) {
                loginResponse.isValid = true
            }
        }
        
        if let message = response["message"] as? String {
            loginResponse.message = message
        }
        
        return loginResponse
    }
}
