//
//  SideMenuView.swift
//  24HANEMobile
//
//  Created by Katherine JANG on 12/8/22.
//

import SwiftUI

struct SideMenuView: View {
    
    @ObservedObject var isSigned: IsSignedIn

    
    var intraID: String
    let menuToggle: () -> Void
        
    var body: some View{
        ZStack(alignment: .leading) {
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
                        Image("24HaneLogo")
                            .resizable()
                            .frame(width: 60, height: 50)
                        Text(" \(intraID)")
                            .textCase(.uppercase)
                            .font(.system(size: 25, weight: .medium, design: .default))
                            .foregroundColor(.textfordata)
                            .font(.headline)
                        Spacer()
                    }
                    .padding(.top, 100)
                    URLButtonView(url: "https://www.notion.so", Image: Image(systemName: "person.fill.questionmark"), title: "How to use?")
                        .padding(.top, 30)
                    URLButtonView(url: "https://www.github.com", Image: Image("githubLogo"), title: "Android Dev")
                        .padding(.top, 10)
                    URLButtonView(url: "https://www.github.com", Image: Image("githubLogo"), title: "IOS Dev")
                        .padding(.top, 10)
                    URLButtonView(url: "https://spot-tomato-468.notion.site/2022-42-SEOUL-bf0513c7197f4f71b4be968b8a2cd75a", Image: Image("42Logo"), title: "지원금 지침 안내")
                        .padding(.top, 10)
                    URLButtonView(url: "https://developer.apple.com", Image: Image(systemName: "questionmark.circle.fill"), title: "문의사항")
                        .padding(.top, 10)
                    Spacer()
                    HStack {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                            .resizable()
                            .frame(width: 25.0, height: 25.0)
                            .foregroundColor(.black)
                            .imageScale(.large)
                        Button(action: {
                            isSigned.SignOut()
                            self.menuToggle()
                        }){
                            Text("Sign Out")
                                .foregroundColor(.gray)
                                .font(.headline)
                        }
                    }
                    .padding()
                }
                .padding()
                .frame(width: geometry.size.width / 1.5)
                .background(.white)
                .edgesIgnoringSafeArea(.all)
                .position(x: geometry.size.width * 0.75, y: geometry.size.height / 2)
            }
        }
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView(isSigned: IsSignedIn(),intraID: "hejang") {
            print("sidemenu toggle")
        }
    }
}
