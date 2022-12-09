//
//  MainView.swift
//  24HANEMobile
//
//  Created by Katherine JANG on 12/8/22.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var apiHandler: APIHandler
    @State private var today = Date()
    @ObservedObject var isSigned: IsSignedIn
    @State var network = false
    @State private var showingAlert = !NetworkManager().isConnected
    @Binding var showMenu: Bool
    
    @State private var loadData = false
    
    var body: some View {
        VStack {
            if isSigned.isSignIn == false {
                SignInWebView(
                    url: URL(string:"https://api.24hoursarenotenough.42seoul.kr/user/login/42?redirect=42")!,
                    isSigned: isSigned
                )
            } else if isSigned.isSignIn == true {
                VStack{
                    if loadData == false {
                        isLoading()
                    } else if loadData == true {
                        HeaderView(showMenu: $showMenu)
                            .refreshable {
                                do{
                                    try await apiHandler.getMainInfo()
                                } catch {
                                    self.isSigned.isSignIn = false
                                    print("error")
                                }
                                do{
                                    try await apiHandler.getAccumulationTime()
                                } catch {
                                    self.isSigned.isSignIn = false
                                    print("error")
                                }
                                do{
                                    try await apiHandler.getMonthLogs(year: today.year , month: today.month)
                                } catch {
                                    self.isSigned.isSignIn = false
                                    print("error")
                                }
                            }
                        TabView{
                            SummaryView()
                                .environmentObject(apiHandler)
                            DetailView()
                        }
                        .tabViewStyle(.page)
                        .indexViewStyle(.page(backgroundDisplayMode: .always))
                    }
                }
                .task {
                    do{
                        try await apiHandler.getMainInfo()
                    } catch {
                        isSigned.isSignIn = false
                        print("error")
                    }
                    do{
                        try await apiHandler.getAccumulationTime()
                    } catch {
                        isSigned.isSignIn = false
                        print("error")
                    }
                    do{
                        try await apiHandler.getMonthLogs(year: 2022, month: 12)
                    } catch {
                        isSigned.isSignIn = false
                        print("error")
                    }
                    loadData = true
                }
            }
        }
        .alert(isPresented: $showingAlert){
            Alert(title: Text("Error"), message: Text("Network not connected"),
            dismissButton: .default(Text("Retry"), action: {
                network = true
            }))
        }
    }
}

//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//    }
//}
