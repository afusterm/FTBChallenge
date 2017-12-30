//
//  File.swift
//  FTBChallenge
//
//  Created by Alejandro on 29/12/2017.
//  Copyright © 2017 Alejandro. All rights reserved.
//

import Foundation

public protocol HttpRequester {
    func data(request: URLRequest, receive: @escaping (Data) -> Void)
}
