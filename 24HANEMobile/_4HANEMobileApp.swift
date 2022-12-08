//
//  _4HANEMobileApp.swift
//  24HANEMobile
//
//  Created by Katherine JANG on 11/29/22.
//

import SwiftUI


@main
struct _4HANEMobileApp: App {
    var apihandler = APIHandler()
    var isSigned = IsSignedIn()
    var apiTmp = APIHanderTmp()
    var body: some Scene {
        WindowGroup {
            ContentView(isSigned: IsSignedIn())
                .environmentObject(apihandler)
                .environmentObject(isSigned)
                .environmentObject(apiTmp)
        }
    }
}
