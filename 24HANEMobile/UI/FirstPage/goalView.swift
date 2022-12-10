//
//  goalView.swift
//  24HANEMobile
//
//  Created by Katherine JANG on 12/10/22.
//

import SwiftUI

struct goalView: View {
    let hour: Int
    let inoutState: String
    var body: some View {
        Label("\(hour) : 00", systemImage: "")
            .font(.system(size: 35, weight: .medium, design: .default))
            .foregroundColor((inoutState == "IN") ? Color.textfordata : Color.checkOutGray)
    }
}

struct goalView_Previews: PreviewProvider {
    static var previews: some View {
        goalView(hour: 10, inoutState: "IN")
        
    }
}
