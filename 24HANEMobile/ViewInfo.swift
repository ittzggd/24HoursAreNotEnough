//
//  ViewInfo.swift
//  24HANEMobile
//
//  Created by Katherine JANG on 12/4/22.
//

import Foundation
import WebKit

class IsSignedIn: ObservableObject {
    @Published var isSignIn = false
    
    func SignOut() {
        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes(), completionHandler: {
                    (records) -> Void in
                    for record in records{
                        WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
                    }
                })
        UserDefaults.standard.removeObject(forKey: "Token")
        isSignIn = false
    }
}
