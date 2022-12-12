//
//  isLoading.swift
//  24HANEMobile
//
//  Created by Katherine JANG on 12/4/22.
//

import SwiftUI

struct isLoading: View {
    @State private var isLoading = false
    var body: some View {
        VStack(spacing: 40){
//            ProgressView()
//                .scaleEffect(2)
            HStack{
                Text("Loading....")
                    .font(.system(size: 25, weight: .medium, design: .default))
                    .foregroundColor(Color.gray)
                Image(systemName: "tortoise.fill")
                    .offset(x: isLoading ? 40 : 0, y: 0)
                    .animation(Animation.linear(duration: 3).repeatForever(autoreverses: false))
                    .foregroundColor(Color.LogoColor)
            }
        }
        .onAppear{
            self.isLoading = true
        }
    }
}

struct isLoading_Previews: PreviewProvider {
    static var previews: some View {
        isLoading()
    }
}
