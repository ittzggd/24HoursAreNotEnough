//
//  isLoading.swift
//  24HANEMobile
//
//  Created by Katherine JANG on 12/4/22.
//

import SwiftUI

struct isLoading: View {
    var body: some View {
        VStack(spacing: 40){
            ProgressView()
                .scaleEffect(2)
            HStack{
                Text("Loading....")
                    .font(.system(size: 25, weight: .medium, design: .default))
                    .foregroundColor(Color.gray)
                Image(systemName: "tortoise.fill")
                    .foregroundColor(Color.LogoColor)
            }
        }
    }
}

struct isLoading_Previews: PreviewProvider {
    static var previews: some View {
        isLoading()
    }
}
