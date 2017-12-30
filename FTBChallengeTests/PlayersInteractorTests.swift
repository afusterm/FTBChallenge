//
//  PlayersInteractorTests.swift
//  FTBChallengeTests
//
//  Created by Alejandro on 30/12/2017.
//  Copyright © 2017 Alejandro. All rights reserved.
//

import XCTest
@testable import FTBChallenge

class PlayersInteractorTests: XCTestCase {
    private let requester = HttpRequesterStub()
    
    let response = ["{",
        "\"players\": [",
        "{",
            "\"nombre\": \"Diogo Figueiras \",",
            "\"url\": \"http://ftbsports.com/ios/cdn/r_2919.png\"",
        "},",
        "{",
            "\"nombre\": \"Isco \",",
            "\"url\": \"http://ftbsports.com/ios/cdn/r_3024.png\"",
        "},",
        "{",
            "\"nombre\": \"J. Henderson \",",
            "\"url\": \"http://ftbsports.com/ios/cdn/r_7215.png\"",
        "},",
    "]",
    "}"]
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDownloadSignings_responseWithPlayers_countReturnsThree() {
        let exp = expectation(description: "PlayersInteractor")
        requester.response = response.joined()
        let sut = PlayersInteractor(requester: requester)
        var players = Players()
        sut.downloadSignings { (playersDownloaded) in
            players = playersDownloaded
            exp.fulfill()
        }
        
        waitForExpectations(timeout: expectationTimeout, handler: nil)
        XCTAssert(players.count == 3)
    }
    
    func testDownloadSignings_responseWithNull_countReturnsZero() {
        let exp = expectation(description: "PlayersInteractor")
        requester.response = "{ \"players\": null }"
        let sut = PlayersInteractor(requester: requester)
        var players = Players()
        sut.downloadSignings { (playersDownloaded) in
            players = playersDownloaded
            exp.fulfill()
        }
        
        waitForExpectations(timeout: expectationTimeout, handler: nil)
        XCTAssert(players.count == 0)
    }
}
