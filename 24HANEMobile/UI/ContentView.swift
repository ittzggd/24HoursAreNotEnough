//
//  ContentView.swift
//  24HANEMobile
//
//  Created by Katherine JANG on 11/29/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var apihandler: APIHandler
    @State var isSignedIn = false
    @State private var load = false
    @State private var inOutState = false
    @State private var date = Date()
    @ObservedObject var isSigned: IsSignedIn
    @State var network = false
    @State private var showingAlert = !NetworkManager().isConnected
    
    @State private var loadData = false
    var accTime: accumationTimes{apihandler.accTime}
    var info: mainInfo{apihandler.userInfo}
    var monthLogs: [inOutStamp]{apihandler.monthLogs.inOutLogs}
    
    var body: some View {
        VStack {
            if isSigned.page == "beforeSignIn" {
                SignInWebView(
                    url: URL(string:"https://api.24hoursarenotenough.42seoul.kr/user/login/42?redirect=42")!,
                    showWebView: $isSignedIn,
                    isSigned: isSigned
                )
                .onDisappear{
                    print("isSignedIn\(isSignedIn)")
                    print(getTokenfromFile())
                }
            } else if isSigned.page == "afterSignIn" {
                VStack{
                    if loadData == false {
                        isLoading()
                    } else if loadData == true {
                        HeaderView()
                        TabView{
                            MainView(accTime: accTime, inoutState: $inOutState)
                            DetailView(inOutLogs: monthLogs, selectedDay: date.day)
                        }
                        .tabViewStyle(.page)
                        .indexViewStyle(.page(backgroundDisplayMode: .always))
                    }
                }
                .onAppear{
                    print("hi from loading")
                    guard let Token = UserDefaults.standard.string(forKey: "Token") else {
                        print("토큰 읎다")
                        return
                    }
                    apihandler.getAccumulationTimes(token: Token){(isSuccess, accumationTimes) in
                      if isSuccess{
                          loadData = true
                      }
                       
                    }
                    apihandler.getUserInfo(token: Token){(isSuccess, mainInfo) in
                      if isSuccess{
                        if info.inoutState == "in"{
                          inOutState = true
                        }
                      }
                    }
                    apihandler.getMonthLogs(token: Token, year: date.yearName, month: String(date.month)){(isSuccess, monthLogs) in
                      if isSuccess{
                        print("success")
                      }
                    }
                }
            }
        }
        .onAppear{
            isSignedIn = isSignIn(apihandler: apihandler) ? true : false
        }
        .alert(isPresented: $showingAlert){
            Alert(title: Text("Error"), message: Text("Network not connected"),
            dismissButton: .default(Text("Retry"), action: {
                network = true
            }))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(isSignedIn: true, isSigned: IsSignedIn())
    }
}
