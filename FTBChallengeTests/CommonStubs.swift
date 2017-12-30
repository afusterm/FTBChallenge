//
//  CommonStubs.swift
//  FTBChallengeTests
//
//  Created by Alejandro on 30/12/2017.
//  Copyright © 2017 Alejandro. All rights reserved.
//

import Foundation
import XCTest
@testable import FTBChallenge

let expectationTimeout = TimeInterval(10)

class HttpRequesterStub: HttpRequester {
    var response: String
    
    init(response: String = "{\"status\":0}") {
        self.response = response
    }
    
    func data(request: URLRequest, receive: @escaping (Data) -> Void) {
        let data = response.data(using: String.Encoding.utf8)
        receive(data!)
    }
}
