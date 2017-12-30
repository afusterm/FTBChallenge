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

private struct LoginResponse {
    var isValid: Bool
    var message: String
    
    init() {
        isValid = false
        message = ""
    }
}

class LoginInteractor {
    private let loginUrl = "http://ftbsports.com/ios/api/login.php"
    
    private var requester: HttpRequester
    
    public init(requester: HttpRequester = URLSession(configuration: URLSessionConfiguration.default)) {
        self.requester = requester
    }
    
    func login(info: LoginInfo, closure: @escaping (_ isValid: Bool, _ message: String?) -> Void) {
        let request = createLoginRequest(info: info)
        
        requester.data(request: request) { (data) in
            let dictionary = try? JSONSerialization.jsonObject(with: data, options: [])
            if let dict = dictionary as? JSONDictionary {
                let loginResponse = self.decodeLoginResponse(response: dict)
                closure(loginResponse.isValid, loginResponse.message)
            }
        }
    }
    
    private func createLoginRequest(info: LoginInfo) -> URLRequest {
        var request = URLRequest(url: URL(string: loginUrl)!)
        let params = "user=\(info.user)&password=\(info.password)"
        request.httpMethod = "POST"
        request.httpBody = params.data(using: .utf8)
        
        return request
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
