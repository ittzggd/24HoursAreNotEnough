//
//  Header.swift
//  24HANEMobile
//
//  Created by Katherine JANG on 11/29/22.
//

import SwiftUI

struct HeaderView: View {
    @Environment(\.refresh) private var refresh
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
                            ProgressView()
                        } else {
                            Button(){
                                isLoading = true
                                async{
                                    await refresh()
                                    isLoading = false
                                }
                            } label:{
                                Image(systemName: "arrow.clockwise")
                                    .resizable()
                                    .frame(width: 23, height: 27)
                                    .foregroundColor(.black)
                            }
                        }
                    }
                    Button{
                        print("Side menu")
                    } label:{
                        Image(systemName: "line.3.horizontal")
                            .resizable()
                            .frame(width: 25, height: 20)
                            .foregroundColor(.black)
                    } .padding()
                }
                Divider()
            }
            Spacer()
        }
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
