//
//  DetailView.swift
//  24HANEMobile
//
//  Created by Katherine JANG on 12/1/22.
//

import SwiftUI

struct DetailView: View {
    var inOutLogs: Array<inOutStamp>
    var groupedLogs: [String: inOutStamp] {
        get {
            return sumAccumulationTime(inoutStamp: inOutLogs)
        }
    }
    var date = Date()
    @State var selectedDay = Date().day
    var filteredInOutStamp: Array<inOutStamp> {
        get{
            return filteringInOutStaemp(inOutStamp: inOutLogs, year: date.year, month: date.month, day: selectedDay)
        }
    }
    
    var body: some View {
        VStack(){
            HeaderView()
                .frame(height: 80)
            Spacer(minLength: 0)
            CalendarView(logTimeColor: calculateLogColor(timeLogs: groupedLogs, year: date.year, month: date.month)){ day in
                selectedDay = day
            }
            
            PickedDataView(
                dailyHours: getDailyAccumulationTime(
                    monthLogs: groupedLogs,
                    year: date.year,
                    month: date.month,
                    day: selectedDay
                ),
                monthlyHours: getMonthlyAccumulationTime(
                    monthLogs: groupedLogs
                )
            )
            .position(x: 180, y: 10)
            
            TagLogView(
                tagLogData: parsedLog(
                    inoutLog: filteredInOutStamp
                )
            )
            .frame(width: 360, height: 250)
            .position(x: 180, y: 0)
        }
        .padding()
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(inOutLogs: [inOutStamp(inTimeStamp: 0, outTimeStamp: 0, durationSecond: 0)], selectedDay: 0)
    }
}
