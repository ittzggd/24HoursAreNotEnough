//
//  UserData.swift
//  24HANEMobile
//
//  Created by Katherine JANG on 12/4/22.
//

import Foundation

func isSignIn(apihandler: APIHandler) -> Bool {
    guard let token = UserDefaults.standard.string(forKey: "Token") else {
        return false
    }
    return apihandler.isLogIn(token: token)
}
