//
//  DetailView.swift
//  24HANEMobile
//
//  Created by Katherine JANG on 12/1/22.
//

import SwiftUI

func loadMonthLogs(year: String, month: String) async -> Array<inOutStamp>{
    let token = getTokenfromFile()
//      let request = URLRequest(url: URL(string: "https://httpbin.org/delay/2")!)
    let url = "https://api.24hoursarenotenough.42seoul.kr/v1/tag-log/permonth"
    var components = URLComponents(string: url)
    let year = URLQueryItem(name: "year", value: year)
    let month = URLQueryItem(name: "month", value: month)
    components?.queryItems = [year, month]
    let requrl = components?.url
    var request = URLRequest(url: requrl!)
    request.httpMethod = "GET"
    request.allHTTPHeaderFields = [
        "Authorization" : "Bearer \(token)"
    ]
    let (data, response) = try! await URLSession.shared.data(for: request)
    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
       return [inOutStamp(inTimeStamp: 0, outTimeStamp: 0, durationSecond: 0)]
    }
    let decodedPerMonth =  try! await JSONDecoder().decode(perMonth.self, from: data)
    
    return decodedPerMonth.inOutLogs
}

struct DetailView: View {
    @State var inOutLogs: Array<inOutStamp>
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
//            HeaderView()
//                .refreshable{
//                    inOutLogs = await loadMonthLogs(year: "2022", month: "12")
//                }
//                .frame(height: 80)
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
