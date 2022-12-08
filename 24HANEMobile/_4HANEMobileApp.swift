//
//  _4HANEMobileApp.swift
//  24HANEMobile
//
//  Created by Katherine JANG on 11/29/22.
//

import SwiftUI


@main
struct _4HANEMobileApp: App {
    var isSigned = IsSignedIn()
    var apiHandler = APIHandler()
    var body: some Scene {
        WindowGroup {
            ContentView(isSignedIn: IsSignedIn())
                .environmentObject(isSigned)
                .environmentObject(apiHandler)
        }
    }
}
