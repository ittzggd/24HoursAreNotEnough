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
    var body: some View {
        VStack{

            HStack{
                Text("  24HoursAreNotEnough")
                    .font(.system(size: 20, weight: .light, design: .default))
                    .foregroundColor((apiTmp.userInfo.inoutState == "IN") ? Color.LogoColor : Color.checkOutGray)
                Spacer()
            }
            Spacer(minLength: 0)
            HStack{
                Text("    Today")
                    .font(.system(size: 20, weight: .medium, design: .default))
                    .foregroundColor((apiTmp.userInfo.inoutState == "IN") ? Color.textfordata : Color.checkOutGray)
                Spacer()
            }
            DailyView(currentTime: self.apiTmp.accTime.todayAccumationTime)
            Spacer(minLength: 5)
            HStack{
                Text("    Month")
                    .font(.system(size: 20, weight: .medium, design: .default))
                    .foregroundColor((apiTmp.userInfo.inoutState == "IN") ? Color.textfordata : Color.checkOutGray)
                Spacer()
            }
            MonthlyView(currentTime: self.apiTmp.accTime.monthAccumationTime)
            Spacer()
        }
    }

}

struct Summary_Previews: PreviewProvider {
    static var previews: some View {
        SummaryView()
    }
}
