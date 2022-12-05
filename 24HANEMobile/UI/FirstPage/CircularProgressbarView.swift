//
//  CircularProgressbarView.swift
//  24HANEMobile
//
//  Created by Katherine JANG on 11/29/22.
//

import SwiftUI

struct CircularProgressbarView: View {
    let progress: Double
    var body: some View {
        ZStack{
            if progress >= 1{
                Text("100%")
                    .font(.system(size: 30, weight: .medium, design: .default))
                    .foregroundColor(Color.progressbarText)
            } else{
                Text("\(Int(progress * 100))%")
                    .font(.system(size: 30, weight: .medium, design: .default))
                    .foregroundColor(Color.progressbarText)
            }
            Circle()
                .stroke(
                    Color(UIColor.systemGray3).opacity(0.5),
                    lineWidth: 13
                )
            Circle()
                .trim(from:0, to: (progress))
            //user data 맞춰서 to 변경
                .stroke(
                    Color.progressbarblue,
                    style: StrokeStyle(
                        lineWidth: 13,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(270))
        }
    }
}

struct CircularProgressbarView_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgressbarView(progress: 0.72)
    }
}
