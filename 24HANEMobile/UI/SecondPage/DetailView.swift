//
//  DetailView.swift
//  24HANEMobile
//
//  Created by Katherine JANG on 12/1/22.
//

import SwiftUI

struct DetailView: View {
    
    @EnvironmentObject var apiTmp: APIHandler
    @State var selectedDay = Date().day
    
    var today = Date()
    
    var groupedLogs: [String: inOutStamp] {
        get {
            return sumAccumulationTime(inoutStamp: apiTmp.monthLogs.inOutLogs)
        }
    }
    var filteredInOutStamp: Array<inOutStamp> {
        get{
            return filteringInOutStaemp(inOutStamp: apiTmp.monthLogs.inOutLogs, year: today.year, month: today.month, day: selectedDay)
        }
    }
    
    var body: some View {
        VStack(alignment: .center){
            HStack{
                Text("\(today.monthName)")
                    .font(.system(size: 20, weight: .semibold, design: .default))
                    .foregroundColor(Color.calendarDate)
                Text("\(today.yearName)")
                    .font(.system(size: 20, weight: .semibold, design: .default))
                    .foregroundColor(Color.calendarDate)
            }
            .padding(.top, 10)
            CalendarView(logTimeColor: calculateLogColor(timeLogs: groupedLogs, year: today.year, month: today.month)){ day in
                selectedDay = day
            }
            PickedDataView(
                dailyHours: getDailyAccumulationTime(
                    monthLogs: groupedLogs,
                    year: today.year,
                    month: today.month,
                    day: selectedDay
                ),
                monthlyHours: getMonthlyAccumulationTime(
                    monthLogs: groupedLogs
                ),
                selectedDate: selectedDay
            )
            TagLogView(
                tagLogData: parsedLog(
                    inoutLog: filteredInOutStamp
                )
            )
            .frame(width: 360, height: 230)
            Spacer()
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(selectedDay: 0)
    }
}
