//
//  URLButtonView.swift
//  24HANEMobile
//
//  Created by Katherine JANG on 12/10/22.
//

import SwiftUI
import Foundation

struct URLButtonView: View {
    
    @Environment(\.openURL) private var openURL

    let url: String
    let Image: Image
    let title: String
    
    var body: some View {
        HStack{
            Image
                .resizable()
                .frame(width: 25.0, height: 25.0)
                .foregroundColor(.black)
                .imageScale(.large)
            Button {
                if let url = URL(string: url) {
                    openURL(url)
                }
            } label: {
                Text(title)
                    .foregroundColor(.gray)
                    .font(.headline)
            }
        }
    }
}

struct URLButtonView_Previews: PreviewProvider {
    static var previews: some View {
        URLButtonView(url: "https://developer.apple.com", Image: Image(systemName: "questionmark.circle.fill"), title: "")
    }
}
