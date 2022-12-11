//
//  Header.swift
//  24HANEMobile
//
//  Created by Katherine JANG on 11/29/22.
//

import SwiftUI

struct HeaderView: View {
    @Environment(\.refresh) private var refresh
    @Environment(\.colorScheme) var colorScheme
    @Binding var showMenu: Bool
    @State private var isLoading = false
    
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                HStack{
                    Text(" ")
                    Image("24HaneLogo")
                        .resizable()
                        .frame(width: 55, height:40)
                    Spacer()
                    if let refresh = refresh {
                        if isLoading {
                            VStack(alignment: .leading){
                                ProgressView()
                                    .frame(width: 27, height: 27)
                            }
                        } else {
                            Button(){
                                isLoading = true
                                Task{
                                    await refresh()
                                    isLoading = false
                                }
                            } label:{
                                Image(systemName: "goforward")
                                    .resizable()
                                    .frame(width: 27, height: 27)
                                    .foregroundColor(colorScheme == .light ? .black : .white)
                                    .rotationEffect(.degrees(90))
                            }
                        }
                    }
                    Button{
                        self.showMenu.toggle()
                        print("Side menu")
                    } label:{
                        Image(systemName: "line.3.horizontal")
                            .resizable()
                            .frame(width: 25, height: 20)
                            .foregroundColor(colorScheme == .light ? .black : .white)
                    } .padding()
                }
                Divider()
            }
        }
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(showMenu: .constant(true))
    }
}
