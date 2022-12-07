//
//  SecondPageHeaderView.swift
//  24HANEMobile
//
//  Created by Katherine JANG on 12/2/22.
//

import SwiftUI

struct SecondPageHeaderView: View {
    var body: some View {
        VStack{
            HStack{
                Text(" ")
                Image("24HaneLogo")
                    .resizable()
                    .frame(width: 55, height:40)
                Spacer()
                Button{
                    print("Reload")
                } label:{
                    Image(systemName: "arrow.triangle.2.circlepath")
                        .resizable()
                        .frame(width: 30, height: 25)
                        .foregroundColor(.black)
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
            Text("")
        }
    }
}

struct SecondPageHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        SecondPageHeaderView()
    }
}
