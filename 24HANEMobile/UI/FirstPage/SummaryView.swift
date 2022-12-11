//
//  MainView.swift
//  24HANEMobile
//
//  Created by Katherine JANG on 11/29/22.
//

import SwiftUI
import Foundation

struct SummaryView: View {
    @EnvironmentObject var apiTmp: APIHandler
    
    var dailyOptions: Array<Double> = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]
    var monthlyOptions: Array<Double> = [20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200, 210, 220, 230, 240]
    
    var body: some View {
        VStack{
            HStack{
                Text("  24HoursAreNotEnough")
                    .font(.system(size: 20, weight: .light, design: .default))
                    .foregroundColor((apiTmp.userInfo.inoutState == "IN") ? Color.LogoColor : Color.checkOutGray)
                Spacer()
            }
            Text("")
            Text("")
            HStack{
                Text("    Today")
                    .font(.system(size: 20, weight: .medium, design: .default))
                    .foregroundColor((apiTmp.userInfo.inoutState == "IN") ? Color.textfordata : Color.checkOutGray)
                Spacer()
            }
           CardView(options: dailyOptions, type: "day", currentTime: self.apiTmp.accTime.todayAccumationTime)
                .padding()
            HStack{
                Text("    Month")
                    .font(.system(size: 20, weight: .medium, design: .default))
                    .foregroundColor((apiTmp.userInfo.inoutState == "IN") ? Color.textfordata : Color.checkOutGray)
                Spacer()
            }
            CardView(options: monthlyOptions, type: "month", currentTime: self.apiTmp.accTime.monthAccumationTime)
            Spacer()
        }
    }

}

struct Summary_Previews: PreviewProvider {
    static var previews: some View {
        SummaryView()
    }
}
