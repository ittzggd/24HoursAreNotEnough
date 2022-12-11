//
//  TagLogView.swift
//  24HANEMobile
//
//  Created by Katherine JANG on 12/1/22.
//

import SwiftUI

struct TagLogView: View {
    var tagLogData: Array<tagLog>
    
    var body: some View {
        VStack(spacing: 0){
            HStack{
                Text("Logs")
                    .font(.system(size: 15, weight: .medium, design: .default))
                    .foregroundColor(Color.gray)
                Spacer()
            }
            TagLogHeaderView()
            List {
                ForEach(tagLogData){ logdata in
                    TagLogBodyView(tagLogs: logdata)
                }
            }
            .listStyle(.plain)
        }
    }
}

struct TagLogView_Previews: PreviewProvider {
    static var previews: some View {
        TagLogView(tagLogData: [tagLog.init(inTimeStamp: "12:04:00", outTimeStamp: "13:06:12", durationTime: "01:02:12:", date: "2022.12.01")])
    }
}
