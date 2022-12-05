//
//  TagLogBodyView.swift
//  24HANE
//
//  Created by jaewon on 2022/11/08.
//

import SwiftUI

struct TagLogBodyView: View {
    var tagLogs: tagLog
    
    var body: some View {
        HStack {
            Text(tagLogs.inTimeStamp)
                .frame(maxWidth: .infinity)
            Text(tagLogs.outTimeStamp)
                .frame(maxWidth: .infinity)
            Text(tagLogs.durationTime)
                .frame(maxWidth: .infinity)
        }
    }
}

struct TagLogBodyView_Previews: PreviewProvider {
    static var previews: some View {
        TagLogBodyView(tagLogs: tagLog(inTimeStamp: "", outTimeStamp: "", durationTime: "", date: ""))
    }
}
