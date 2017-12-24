//
//  LoginInteractor.swift
//  FTBChallenge
//
//  Created by Alejandro on 22/12/2017.
//  Copyright © 2017 Alejandro. All rights reserved.
//

import Foundation

class LoginInteractor {
    func login(userName: String, password: String, closure: (_ isValid: Bool, _ message: String?) -> Void) {
        closure(true, nil)
    }
}
