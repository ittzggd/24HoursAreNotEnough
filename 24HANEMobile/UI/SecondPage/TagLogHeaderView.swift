//
//  TagLogHeaderView.swift
//  24HANE
//
//  Created by jaewon on 2022/11/08.
//

import SwiftUI

struct TagLogHeaderView: View {
    var body: some View {
        HStack {
            Text("입실")
                .frame(maxWidth: .infinity)
            Spacer()
            Text("퇴실")
                .frame(maxWidth: .infinity)
            Spacer()
            Text("체류시간")
                .frame(maxWidth: .infinity)
        }
        .padding()
        .foregroundColor(Color.gray)
    }
}

struct TagLogHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        TagLogHeaderView().previewLayout(.sizeThatFits)
    }
}

