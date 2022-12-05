//
//  UserData.swift
//  24HANEMobile
//
//  Created by Katherine JANG on 12/4/22.
//

import Foundation

func isSignIn(apihandler: APIHandler) -> Bool {
    let tokenFromFile = getTokenfromFile()
    if tokenFromFile == "The file “UserToken.txt” couldn’t be opened." {
        return false
    } else {
        if apihandler.isLogIn(token: tokenFromFile) == true {
            return true
        } else {
            return false
        }
    }
}
