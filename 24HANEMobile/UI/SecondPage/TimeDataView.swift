//
//  TimeDataView.swift
//  24HANEMobile
//
//  Created by Katherine JANG on 12/1/22.
//

import SwiftUI

struct TimeDataView: View {
    var text: String
    var timeData: String
    var body: some View {
        VStack(alignment: .center){
            Text(timeData)
                .font(.system(size: 35, weight: .semibold, design: .default))
                .foregroundColor(Color.gray)
            Text(text)
                .font(.system(size: 20, weight: .light, design: .default))
                .foregroundColor(Color.gray)
        }
    }
}

struct TimeDataView_Previews: PreviewProvider {
    static var previews: some View {
        TimeDataView(text:"Day", timeData: "7h 45m")
    }
}
