//
//  ContentView.swift
//  24HANEMobile
//
//  Created by Katherine JANG on 11/29/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var apihandler: APIHandler
    @EnvironmentObject var apiTmp: APIHanderTmp
    @State var isSignedIn = false
    @State private var inOutState = false
    @State private var date = Date()
    @ObservedObject var isSigned: IsSignedIn
    @State var network = false
    @State private var showingAlert = !NetworkManager().isConnected
    
    @State private var loadData = false
    
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
                }
            } else if isSigned.page == "afterSignIn" {
                VStack{
                    if loadData == false {
                        isLoading()
                    } else if loadData == true {
                        HeaderView()
                            .refreshable {
                                guard let Token = UserDefaults.standard.string(forKey: "Token") else {
                                    print("토큰 읎다")
                                    return
                                }
                                do{
                                    try await self.apiTmp.getAccumulationTime(token: Token)
                                } catch {
                                    print("error")
                                }
                                do{
                                    try await self.apiTmp.getMonthLogs(token: Token, year: 2022, month: 12)
                                } catch {
                                    print("error")
                                }
                            }
                        TabView{
                            MainView(inoutState: $inOutState)
                                .environmentObject(apiTmp)
                            DetailView(selectedDay: date.day)
                        }
                        .tabViewStyle(.page)
                        .indexViewStyle(.page(backgroundDisplayMode: .always))
                    }
                }
                .task {
                    guard let Token = UserDefaults.standard.string(forKey: "Token") else {
                        print("토큰 읎다")
                        return
                    }
                    do{
                        try await apiTmp.getMainInfo(token: Token)
                    } catch {
                        isSigned.page = "beforeSignIn"
                        print("error")
                    }
                    do{
                        try await apiTmp.getAccumulationTime(token: Token)
                    } catch {
                        isSigned.page = "beforeSignIn"
                        print("error")
                    }
                    do{
                        try await apiTmp.getMonthLogs(token: Token, year: 2022, month: 12)
                    } catch {
                        isSigned.page = "beforeSignIn"
                        print("error")
                    }
                    loadData = true
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

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView(isSignedIn: true, isSigned: IsSignedIn())
//    }
//}
