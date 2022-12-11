//
//  ViewInfo.swift
//  24HANEMobile
//
//  Created by Katherine JANG on 12/4/22.
//

import Foundation
import WebKit

enum Status{
    case webViewHidden
    case webViewLoading
    case webViewAppear
    case signInLoading
}

class IsSignedIn: ObservableObject {
    @Published var isSignIn: Bool = false
    @Published var state = Status.webViewHidden
    
    func SignOut() {
        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes(), completionHandler: {
                    (records) -> Void in
                    for record in records{
                        WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
                    }
                })
        UserDefaults.standard.removeObject(forKey: "Token")
        isSignIn = false
        state = .webViewHidden
    }
}
