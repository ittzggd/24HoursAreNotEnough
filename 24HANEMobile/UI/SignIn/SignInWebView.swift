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
    @ObservedObject var isSigned: IsSignedIn
    
    func makeCoordinator() -> WebViewCoordinator {
        WebViewCoordinator(self, isSigned: isSigned)
    }
    
    func makeUIView(context: Context) -> WKWebView{
        let wkWebView = WKWebView()
        wkWebView.navigationDelegate = context.coordinator
        let request = URLRequest(url: url)
        wkWebView.load(request)
        return wkWebView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context){
    }
    
    class WebViewCoordinator: NSObject, WKNavigationDelegate {
        var parent: SignInWebView
        var isSigned: IsSignedIn
        
        init(_ parent: SignInWebView, isSigned: IsSignedIn) {
            self.parent = parent
            self.isSigned = isSigned
            super.init()
        }
        
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            if isSigned.state == .webViewHidden{
                isSigned.state = .webViewLoading
            } else {
                isSigned.state = .signInLoading
            }
            
        }
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            isSigned.state = .webViewAppear
        }
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void){
            let urlToMatch = "/user/login/callback/42"
            if let urlStr = navigationAction.request.url?.path, urlStr == urlToMatch{
                WKWebsiteDataStore.default().httpCookieStore.getAllCookies{ (cookies) in
                    for cookie in cookies{
                        if cookie.name == "accessToken"{
                            UserDefaults.standard.setValue(String(cookie.value), forKey: "Token")
                            self.isSigned.isSignIn = true
                            break
                        }
                    }
                }
                decisionHandler(.allow)
            } else {
                decisionHandler(.allow)
            }
        }
    }
}

struct SignInWebView_Previews: PreviewProvider {
    static var previews: some View {
        SignInWebView(url: URL(string:"https://api.24hoursarenotenough.42seoul.kr/user/login/42?redirect=42")!, isSigned: IsSignedIn())
    }
}
