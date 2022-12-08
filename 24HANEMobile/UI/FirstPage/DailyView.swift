//
//  DailyView.swift
//  24HANEMobile
//
//  Created by Katherine JANG on 11/29/22.
//

import SwiftUI
import Foundation

struct DailyView: View {
    @EnvironmentObject var apiHandler: APIHandler
    var options: Array<Double> = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]
 
//
    @AppStorage("DailySelectionOption") private var selectionOption =  UserDefaults.standard.integer(forKey: "DailySelectionOption")
    
    var currentTime: Int64
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
                    Text("\(parseAccumulationTime(type: "day", date: currentTime))")
                        .font(.system(size: 38, weight: .medium, design: .default))
                        .foregroundColor((apiHandler.userInfo.inoutState == "IN") ? Color.textfordata : Color.checkOutGray)
                        .padding(-2)
                    Text("")
                        .padding(-5)
                    Text("목표시간")
                        .font(.system(size: 17, weight: .regular, design: .rounded))
                        .foregroundColor((apiHandler.userInfo.inoutState == "IN") ? Color.textfordata : Color.checkOutGray)
                    Menu{
                        Picker(selection: $selectionOption) {
                            ForEach(1 ..< options.count + 1) { times in
                                Text("\(Int(options[times - 1]))")
                            }
                        } label: {}
                    } label: {
                        Text("\(Int(options[selectionOption])) : 00")
                            .font(.system(size: 35, weight: .medium, design: .default))
                            .foregroundColor((apiHandler.userInfo.inoutState == "IN") ? Color.textfordata : Color.checkOutGray)
                            .onAppear(){
                                UserDefaults.standard.setValue(selectionOption, forKey: "DailySelectionOption")
                            }

                    }
                }
                .padding(30)
                Divider()
                    .frame(height: 50)
                    .background(Color.black)
                CircularProgressbarView(progress: (Double(currentTime)/3600) / options[selectionOption] )
                    .frame(width: 140, height: 140)
                    .padding()

            }
        }
    }
}

struct DailyView_Previews: PreviewProvider {
    static var previews: some View {
        DailyView(currentTime: 10)
    }
}
