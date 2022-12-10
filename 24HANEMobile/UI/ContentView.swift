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
    
    var body: some View {
        let drag = DragGesture()
                    .onEnded {
                        if $0.translation.width > 100 {
                            withAnimation {}
                                self.showMenu = false
                        }
                    }
        VStack{
            GeometryReader{ geometry in
                ZStack(alignment: .trailing){
                    MainView(isSigned: isSignedIn, showMenu: $showMenu)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                    if self.showMenu {
                        SideMenuView(intraID: apiHandler.userInfo.login) {
                            self.showMenu.toggle()
                        }
                            .transition(.move(edge: .trailing))
                    }
                }
                .gesture(drag)
            }
        }
        .task{
            self.isSignedIn.isSignIn = isSignIn(apihandler: apiHandler) ? true : false
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView(isSignedIn: true, isSigned: IsSignedIn())
//    }
//}
