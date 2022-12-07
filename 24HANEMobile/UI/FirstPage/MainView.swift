//
//  MainView.swift
//  24HANEMobile
//
//  Created by Katherine JANG on 11/29/22.
//

import SwiftUI

struct MainView: View {
    var accTime: accumationTimes
    @Binding var inoutState: Bool
    var body: some View {
        VStack{
            HeaderView()
                .frame(height: 80)
            HStack{
                Text("  24HoursAreNotEnough")
                    .font(.system(size: 20, weight: .light, design: .default))
                    .foregroundColor(Color.LogoColor)
                Spacer()
            }
            Spacer(minLength: 0)
            HStack{
                Text("    Today")
                    .font(.system(size: 20, weight: .medium, design: .default))
                    .foregroundColor(Color.textfordata)
                Spacer()
            }
            DailyView(currentTime: accTime.todayAccumationTime)
            Spacer(minLength: 5)
            HStack{
                Text("    Month")
                    .font(.system(size: 20, weight: .medium, design: .default))
                    .foregroundColor(Color.textfordata)
                Spacer()
            }
            MonthlyView(currentTime: accTime.monthAccumationTime)
            Spacer()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(accTime: accumationTimes(todayAccumationTime: 0, monthAccumationTime: 0), inoutState: .constant(true))
    }
}
