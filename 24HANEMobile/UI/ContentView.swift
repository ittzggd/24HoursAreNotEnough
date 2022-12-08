//
//  ContentView.swift
//  24HANEMobile
//
//  Created by Katherine JANG on 11/29/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var apiHandler: APIHandler
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
                                do{
                                    try await apiHandler.getMainInfo()
                                } catch {
                                    isSigned.page = "beforeSignIn"
                                    print("error")
                                }
                                do{
                                    try await apiHandler.getAccumulationTime()
                                } catch {
                                    isSigned.page = "beforeSignIn"
                                    print("error")
                                }
                                do{
                                    try await apiHandler.getMonthLogs(year: 2022, month: 12)
                                } catch {
                                    isSigned.page = "beforeSignIn"
                                    print("error")
                                }
                            }
                        TabView{
                            MainView(inoutState: $inOutState)
                                .environmentObject(apiHandler)
                            DetailView(selectedDay: date.day)
                        }
                        .tabViewStyle(.page)
                        .indexViewStyle(.page(backgroundDisplayMode: .always))
                    }
                }
                .task {
                    do{
                        try await apiHandler.getMainInfo()
                    } catch {
                        isSigned.page = "beforeSignIn"
                        print("error")
                    }
                    do{
                        try await apiHandler.getAccumulationTime()
                    } catch {
                        isSigned.page = "beforeSignIn"
                        print("error")
                    }
                    do{
                        try await apiHandler.getMonthLogs(year: 2022, month: 12)
                    } catch {
                        isSigned.page = "beforeSignIn"
                        print("error")
                    }
                    loadData = true
                }
            }
        }
        .onAppear{
            isSignedIn = isSignIn(apihandler: apiHandler) ? true : false
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
