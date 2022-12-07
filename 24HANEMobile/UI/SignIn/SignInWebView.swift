//
//  SignInWebView.swift
//  24HANEMobile
//
//  Created by Katherine JANG on 12/2/22.
//

import SwiftUI
import WebKit
import Foundation

struct SignInWebView: UIViewRepresentable {
    
    var url: URL
    @Binding var showWebView: Bool
    @ObservedObject var isSigned: IsSignedIn
    
    func makeCoordinator() -> WebViewCoordinator {
        WebViewCoordinator(self, showWebView: showWebView, isSigned: isSigned)
    }
    
    func makeUIView(context: Context) -> WKWebView{
        let wkWebView = WKWebView()
        wkWebView.navigationDelegate = context.coordinator
        return wkWebView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context){
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    class WebViewCoordinator: NSObject, WKNavigationDelegate {
        var parent: SignInWebView
        var showWebView: Bool
        var isSigned: IsSignedIn
        
        init(_ parent: SignInWebView, showWebView: Bool, isSigned: IsSignedIn) {
            self.parent = parent
            self.showWebView = showWebView
            self.isSigned = isSigned
            super.init()
        }
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void){
            print("hi!")
            let urlToMatch = "/user/login/callback/42"
            var ret = false
            if let urlStr = navigationAction.request.url?.path, urlStr == urlToMatch{
                WKWebsiteDataStore.default().httpCookieStore.getAllCookies{ (cookies) in
                    for cookie in cookies{
                        print(cookie)
                        if cookie.name == "accessToken"{
                            print("access Token exist")
                             ret = saveToken(token: String(cookie.value))
                            if ret == true {
                                print("hi from webview token saved")
                                self.isSigned.page = "afterSignIn"
                                self.showWebView = true
                            }
                        }
                    }
                }
                if ret == true {
                    print("hi guys")
                    isSigned.page = "afterSignIn"
                }
                print("web vew login access")
                decisionHandler(.allow)
            } else {
                decisionHandler(.allow)
            }
        }
    }
}

struct SignInWebView_Previews: PreviewProvider {
    static var previews: some View {
        SignInWebView(url: URL(string:"https://api.24hoursarenotenough.42seoul.kr/user/login/42?redirect=42")!, showWebView: .constant(true), isSigned: IsSignedIn())
    }
}
