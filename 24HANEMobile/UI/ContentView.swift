 //
//  ContentView.swift
//  24HANEMobile
//
//  Created by Katherine JANG on 11/29/22.
//

import SwiftUI

struct ContentView: View {
    @State var showMenu = false
    @EnvironmentObject var apiHandler: APIHandler
    @ObservedObject var isSignedIn: IsSignedIn
    @ObservedObject var networkManager = NetworkManager()
    @State var loading = true

    
    var body: some View {
        let drag = DragGesture()
                    .onEnded {
                        if $0.translation.width > 100 {
                            withAnimation {}
                                self.showMenu = false
                        }
                    }
        VStack{
            if loading == true {
                isLoading()
            } else {
                GeometryReader{ geometry in
                    ZStack(alignment: .trailing){
                        MainView(isSigned: isSignedIn, showMenu: $showMenu)
                            .frame(width: geometry.size.width, height: geometry.size.height)
                        if self.showMenu {
                            SideMenuView(isSigned: isSignedIn, intraID: apiHandler.userInfo.login) {
                                self.showMenu.toggle()
                            }
                            .transition(.move(edge: .trailing))
                        }
                    }
                    .gesture(drag)
                }
            }
        }
        .task{
            self.isSignedIn.isSignIn = await isSignIn(apihandler: apiHandler) ? true : false
            print("signin: \(self.isSignedIn.isSignIn)")
            self.loading = false
        }
        .alert(isPresented: $networkManager.showAlert){
            Alert(title: Text("Error"), message: Text("네트워크 연결 상태를 확인해주세요."),
            dismissButton: .default(Text("다시시도"), action: {
                networkManager.monitoringNetwork{ isConnected in
                    if isConnected {
                        Task{
                            self.isSignedIn.isSignIn = await isSignIn(apihandler: apiHandler) ? true : false
                        }
                    }
                }
            }))
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView(isSignedIn: true, isSigned: IsSignedIn())
//    }
//}
