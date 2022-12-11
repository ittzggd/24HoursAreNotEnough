//
//  PickedDataView.swift
//  24HANEMobile
//
//  Created by Katherine JANG on 12/1/22.
//

import SwiftUI

struct PickedDataView: View {
    var pickedDate = Date()
    var dailyHours: String
    var monthlyHours: String
    var selectedDate: Int

    var body: some View {
        VStack(spacing: -20){
            HStack{
                Text("Date: \(pickedDate.yearMonth).\(selectedDate)")
                    .font(.system(size: 15, weight: .medium, design: .default))
                    .foregroundColor(Color.gray)
                Spacer()
            }.padding()
            HStack{
                TimeDataView(text: "Day", timeData: dailyHours)
                    .padding()
                TimeDataView(text: "Month", timeData: monthlyHours)
                    .padding()
            }
        }
    }
}

struct PickedDataView_Previews: PreviewProvider {
    static var previews: some View {
        PickedDataView(dailyHours: "", monthlyHours: "", selectedDate: 10)
    }
}
