//
//  SwiftUIView.swift
//  24HANEMobile
//
//  Created by Katherine JANG on 12/11/22.
//

import SwiftUI

struct ActivityIndicatorView: UIViewRepresentable {
    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style

    func makeUIView(context: Context) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}

struct WebViewLoaing<Content>: View where Content: View{
    @Binding var isShowing: Bool
    var content: () -> Content
    var body: some View {
        GeometryReader { geometry in
                   ZStack(alignment: .center) {
                       self.content()
                           .disabled(self.isShowing)
                           .blur(radius: self.isShowing ? 3 : 0)

                       VStack {
                           Text("웹뷰는 로딩중")
                               .bold()
                           ActivityIndicatorView(isAnimating: .constant(false), style: .large)
                       }
                       .frame(width: geometry.size.width / 2,
                              height: geometry.size.height / 5)
                       .background(Color.secondary.colorInvert())
                       .foregroundColor(Color.primary)
                       .cornerRadius(20)
                       .opacity(self.isShowing ? 1 : 0)
                   }
            }
    }
}

//struct SwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        WebViewLoaing()
//    }
//}
