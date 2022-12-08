//
//  MonthlyView.swift
//  24HANEMobile
//
//  Created by Katherine JANG on 11/29/22.
//

import SwiftUI

struct MonthlyView: View {
    var options: Array<Double> = [20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200, 210, 220, 230, 240]
    @AppStorage("MonthlySelectionOption") private var selectionOption =  UserDefaults.standard.integer(forKey: "MonthlySelectionOption")
    
    @EnvironmentObject var apiHandler: APIHandler
    var currentTime:Int64
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 360, height: 230)
                .foregroundColor(Color.cardBackground)
                .shadow(color: .checkOutGray, radius: 2, x: 3, y: 4)
            HStack{
                VStack{
                    Text("누적시간")
                        .font(.system(size: 17, weight: .regular, design: .rounded))
                        .foregroundColor((apiHandler.userInfo.inoutState == "IN") ? Color.textfordata : Color.checkOutGray)
                    Text(" \(parseAccumulationTime(type: "month", date: currentTime))")
                        .font(.system(size: 35, weight: .medium, design: .default))
                        .foregroundColor((apiHandler.userInfo.inoutState == "IN") ? Color.textfordata : Color.checkOutGray)
                        .padding(-2)
                    Text("")
                        .padding(-5)
                    Text("목표시간")
                        .font(.system(size: 17, weight: .regular, design: .rounded))
                        .foregroundColor((apiHandler.userInfo.inoutState == "IN") ? Color.textfordata : Color.checkOutGray)
                    Menu{
                        Picker(selection: $selectionOption){
                            ForEach(1 ..< options.count + 1){ times in
                                Text("\(Int(options[times - 1]))")
                            }
                        } label: {}
                    } label: {
                        Text("  \(Int(options[selectionOption])) : 00")
                            .font(.system(size: 35, weight: .medium, design: .default))
                            .foregroundColor((apiHandler.userInfo.inoutState == "IN") ? Color.textfordata : Color.checkOutGray)
                            .onAppear(){
                                UserDefaults.standard.setValue(selectionOption, forKey: "MonthlySelectionOption")
                            }
                    }
                }
                .padding(30)
                Divider()
                    .frame(height: 50)
                    .background(Color.black)
                CircularProgressbarView(progress: (Double(currentTime)/3600) / options[selectionOption])
                    .frame(width: 140, height: 140)
                    .padding()
            }
        }
    }
}

struct MonthlyView_Previews: PreviewProvider {
    static var previews: some View {
        MonthlyView(currentTime: 10)
    }
}
