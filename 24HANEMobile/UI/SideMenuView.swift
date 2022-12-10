//
//  SideMenuView.swift
//  24HANEMobile
//
//  Created by Katherine JANG on 12/8/22.
//

import SwiftUI

struct SideMenuView: View {
    var intraID: String
    let menuToggle: () -> Void
    @Environment(\.openURL) private var openURL
    
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
                        Text("\(intraID)")
                            .font(.system(size: 30, weight: .medium, design: .rounded))
                            .foregroundColor(.textfordata)
                            .font(.headline)
                            .padding()
                        Spacer()
                    }
                    .padding(.top, 100)
                    HStack {
                        Image(systemName: "person.fill.questionmark")
                            .foregroundColor(.black)
                            .imageScale(.large)
                        Button {
                            if let url = URL(string: "https://www.notion.so") {
                                openURL(url)
                            }
                        } label: {
                            Text("How to use?")
                                .foregroundColor(.gray)
                                .font(.headline)
                        }
                    }
                    .padding(.top, 30)
                    HStack {
                        Image("githubLogo")
                            .resizable()
                            .frame(width: 30.0, height: 30.0)
                            .foregroundColor(.gray)
                            .imageScale(.large)
                        Button {
                            if let url = URL(string: "https://www.github.com") {
                                openURL(url)
                            }
                        } label: {
                            Text("Android Dev")
                                .foregroundColor(.gray)
                                .font(.headline)
                        }
                    }
                    HStack {
                        Image("githubLogo")
                            .resizable()
                            .frame(width: 30.0, height: 30.0)
                            .foregroundColor(.gray)
                            .imageScale(.large)
                        Button {
                            if let url = URL(string: "https://www.github.com") {
                                openURL(url)
                            }
                        } label: {
                            Text("IOS Dev")
                                .foregroundColor(.gray)
                                .font(.headline)
                        }
                    }
                    HStack {
                        Image("42Logo")
                            .resizable()
                            .frame(width: 30.0, height: 30.0)
                            .foregroundColor(.gray)
                            .imageScale(.large)
                        Button {
                            if let url = URL(string: "https://spot-tomato-468.notion.site/2022-42-SEOUL-bf0513c7197f4f71b4be968b8a2cd75a") {
                                openURL(url)
                            }
                        } label: {
                            Text("지원금 지침 안내")
                                .foregroundColor(.gray)
                                .font(.headline)
                        }
                    }
                    HStack {
                        Image(systemName: "questionmark.circle.fill")
                            .resizable()
                            .frame(width: 25.0, height: 25.0)
                            .foregroundColor(.black)
                            .imageScale(.large)
                        Button {
                            if let url = URL(string: "https://developer.apple.com") {
                                openURL(url)
                            }
                        } label: {
                            Text(" 문의사항")
                                .foregroundColor(.gray)
                                .font(.headline)
                        }
                    }
                    Spacer()
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
        SideMenuView(intraID: "hejang") {
            print("sidemenu toggle")
        }
    }
}
