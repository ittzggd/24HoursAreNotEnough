//
//  SecondPageHeaderView.swift
//  24HANEMobile
//
//  Created by Katherine JANG on 12/2/22.
//

import SwiftUI

struct SecondPageHeaderView: View {
    var body: some View {
        HStack{
            Text(" ")
            Image("24HaneLogo")
                .resizable()
                .frame(width: 55, height:40)
            Spacer()
        }
    }
}

struct SecondPageHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        SecondPageHeaderView()
    }
}
