//
//  CardView.swift
//  24HANEMobile
//
//  Created by Katherine JANG on 12/9/22.
//

import SwiftUI

struct CardView: View {
    @EnvironmentObject var apiHandler: APIHandler
    @Environment(\.colorScheme) var colorScheme
    @AppStorage("DailySelectionOption") private var dailySelectionOption =  UserDefaults.standard.integer(forKey: "DailySelectionOption")
    @AppStorage("MonthlySelectionOption") private var monthlySelectionOption =  UserDefaults.standard.integer(forKey: "MonthlySelectionOption")

    
    var options: Array<Double>
    var type: String
    var currentTime: Int64
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 360, height: 230)
                .foregroundColor(colorScheme == .light ? Color.cardBackground : Color.futureText)
                .shadow(color: .checkOutGray, radius: 2, x: 3, y: 4)
            HStack{
                VStack{
                    Text("누적시간")
                        .font(.system(size: 17, weight: .regular, design: .rounded))
                        .foregroundColor((apiHandler.userInfo.inoutState == "IN") ? Color.textfordata : Color.checkOutGray)
                    Text("\(parseAccumulationTime(type: type, date: currentTime))")
                        .font(.system(size: 38, weight: .medium, design: .default))
                        .foregroundColor((apiHandler.userInfo.inoutState == "IN") ? Color.textfordata : Color.checkOutGray)
                        .padding(-2)
                    Text("")
                        .padding(-5)
                    Text("목표시간")
                        .font(.system(size: 17, weight: .regular, design: .rounded))
                        .foregroundColor((apiHandler.userInfo.inoutState == "IN") ? Color.textfordata : Color.checkOutGray)
                    Menu{
                        Picker(selection: (type == "day") ? $dailySelectionOption : $monthlySelectionOption) {
                            ForEach(1 ..< options.count + 1) { times in
                                Text("\(Int(options[times - 1])) 시간")
                            }
                        } label: {}
                    } label: {
                        Text("\(Int(options[(type == "day") ? dailySelectionOption : monthlySelectionOption])) : 00")
                            .font(.system(size: 35, weight: .medium, design: .default))
                            .foregroundColor((apiHandler.userInfo.inoutState == "IN") ? Color.textfordata : Color.checkOutGray)
                            .onAppear(){
                                 (type == "day") ?
                                    UserDefaults.standard.setValue(dailySelectionOption, forKey: "DailySelectionOption") :
                                        UserDefaults.standard.setValue(monthlySelectionOption, forKey: "MonthlySelectionOption")
                            }
                        Image(systemName: "chevron.up.chevron.down")
                            .frame(width: 10, height: 10)
                            .foregroundColor(.gray)
                    }
                }
                .padding()
                Divider()
                    .frame(height: 50)
                    .background(Color.black)
                CircularProgressbarView(progress: (Double(currentTime)/3600) / options[(type == "day") ? dailySelectionOption : monthlySelectionOption])
                    .frame(width: 140, height: 140)
                    .padding()
            }
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(options: [20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200, 210, 220, 230, 240], type: "month", currentTime: APIHandler().accTime.monthAccumationTime)
    }
}
