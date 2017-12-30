//
//  LoginInteractorTests.swift
//  FTBChallengeTests
//
//  Created by Alejandro on 29/12/2017.
//  Copyright © 2017 Alejandro. All rights reserved.
//

import XCTest
@testable import FTBChallenge

class LoginInteractorTests: XCTestCase {
    
    private let loginInfo = LoginInfo(user: "user", password: "password")
    private let requester = HttpRequesterStub()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLogin_withLoginOKResponse_isValidTrue() {
        let exp = expectation(description: "loginInteractor")
        let sut = LoginInteractor(requester: requester)
        var valid = false
        var messageReturned = "this must be empty after login"
        sut.login(info: loginInfo, closure: {(isValid, message) -> Void in
            valid = isValid
            messageReturned = message!
            exp.fulfill()
        })
        
        waitForExpectations(timeout: expectationTimeout, handler: nil)
        
        XCTAssert(valid)
        XCTAssert(messageReturned == "")
    }
    
    func testLogin_withUserOrPasswordErrorResponse_isValidFalse() {
        let exp = expectation(description: "loginInteractor")
        requester.response = "{\"status\": -1, \"message\": \"Error en el login. ¿Usuario y contraseña correctos?\"}"
        let sut = LoginInteractor(requester: requester)
        var valid = true
        var messageReturned = ""
        sut.login(info: loginInfo, closure: {(isValid, message) -> Void in
            valid = isValid
            messageReturned = message!
            exp.fulfill()
        })
        
        waitForExpectations(timeout: expectationTimeout, handler: nil)
        
        XCTAssertFalse(valid)
        XCTAssert(messageReturned != "")
    }
    
    func testLogin_withUnknownErrorResponse_isValidFalse() {
        let exp = expectation(description: "loginInteractor")
        requester.response = "{\"status\": -2}"
        let sut = LoginInteractor(requester: requester)
        var valid = true
        sut.login(info: loginInfo, closure: {(isValid, message) -> Void in
            valid = isValid
            exp.fulfill()
        })
        
        waitForExpectations(timeout: expectationTimeout, handler: nil)
        
        XCTAssertFalse(valid)
    }
}
