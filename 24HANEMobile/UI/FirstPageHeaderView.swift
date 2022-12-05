//
//  Header.swift
//  24HANEMobile
//
//  Created by Katherine JANG on 11/29/22.
//

import SwiftUI

struct FirstPageHeaderView: View {
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                HStack{
                    Text(" ")
                    Image("24HaneLogo")
                        .resizable()
                        .frame(width: 55, height:40)
                }
                Text("  24HoursAreNotEnough")
                    .font(.system(size: 20, weight: .light, design: .default))
                    .foregroundColor(Color.LogoColor)
            }
            Spacer()
        }
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        FirstPageHeaderView()
    }
}
