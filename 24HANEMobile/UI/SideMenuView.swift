//
//  SideMenuView.swift
//  24HANEMobile
//
//  Created by Katherine JANG on 12/8/22.
//

import SwiftUI

struct SideMenuView: View {
    let menuToggle: () -> Void
    
    var body: some View{
        ZStack {
            GeometryReader { _ in
                EmptyView()
            }
            .background(Color.gray.opacity(0.7))
            .opacity(0.5)
            .onTapGesture {
                self.menuToggle()
            }

            GeometryReader { geometry in
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "person")
                            .foregroundColor(.gray)
                            .imageScale(.large)
                        Text("Intra ID")
                            .foregroundColor(.gray)
                            .font(.headline)
                    }
                    .padding(.top, 100)
                    HStack {
                        Image("Github")
                            .resizable()
                            .frame(width: 30.0, height: 30.0)
                            .foregroundColor(.gray)
                            .imageScale(.large)
                        Text("Dev github")
                            .foregroundColor(.gray)
                            .font(.headline)
                    }
                    .padding(.top, 30)
                    HStack {
                        Image(systemName: "rosette")
                            .foregroundColor(.gray)
                            .imageScale(.large)
                        Text("Licnese")
                            .foregroundColor(.gray)
                            .font(.headline)
                    }
                    .padding(.top, 30)
                    Spacer()
                }
                .padding()
    //            .frame(maxWidth: .infinity, alignment: .trailing)
                .frame(width: geometry.size.width / 2)
                .background(Color(red: 32/255, green: 32/255, blue: 32/255))
                .edgesIgnoringSafeArea(.all)
                .position(x: geometry.size.width * 0.75, y: geometry.size.height / 2)
            }
        }
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView() {
            print("sidemenu toggle")
        }
    }
}
