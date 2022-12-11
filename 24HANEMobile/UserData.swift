//
//  UserData.swift
//  24HANEMobile
//
//  Created by Katherine JANG on 12/4/22.
//

import Foundation

func isSignIn(apihandler: APIHandler) async -> Bool {
    var ret = false
    guard let _ = UserDefaults.standard.string(forKey: "Token") else {
        return false
    }
    do{
        ret = try await apihandler.isLogin()
    } catch {
        print("error")
    }
    return ret
}
