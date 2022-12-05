//
//  CalculateAccumulationTime.swift
//  24HANEMobile
//
//  Created by Katherine JANG on 12/1/22.
//

import Foundation
import SwiftUI

func sumAccumulationTime(inoutStamp: Array<inOutStamp>) -> [String: inOutStamp] {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "YYYY-MM-d"
    let dict = Dictionary(grouping: inoutStamp) {dateFormatter.string(from:Date(milliseconds: $0.inTimeStamp))}
    let dict2 = dict.mapValues{(arr:[inOutStamp]) -> inOutStamp in
    let sum = arr.reduce(0) {
        $0 + $1.durationSecond
        }
        return inOutStamp(inTimeStamp: arr[0].inTimeStamp, outTimeStamp: arr[0].outTimeStamp, durationSecond: sum)
    }
//    var sortedarr = dict2.sorted{$0.0 < $1.0}
    return (dict2)
}

func getMonthlyAccumulationTime(monthLogs: [String: inOutStamp]) -> String {
    var totalTime: Int64 = 0
    let hours: Int64
    let dateFormatter = DateFormatter()
    var monthlyAccumulationTime: String
    
    totalTime = monthLogs.compactMap{Int64($0.value.durationSecond)}.reduce(0, +)
    let formatteddate = Date(timeIntervalSince1970: TimeInterval(totalTime - 32400))
    hours = totalTime / 3600
    dateFormatter.dateFormat = "mm"
    monthlyAccumulationTime = "\(hours)h " + dateFormatter.string(from:formatteddate) + "m"
    
    return monthlyAccumulationTime
}

func getDailyAccumulationTime(monthLogs: [String: inOutStamp], year: Int, month: Int, day: Int) -> String{
    var dailyAccumulationTime: String
    let hours: Int64
    let dateFormatter = DateFormatter()
    guard let selectedDay = monthLogs["\(year)-\(month)-\(day)"] else {
        return "0h 0m"
    }
    hours = selectedDay.durationSecond / 3600
    let formatteddate = Date(timeIntervalSince1970: TimeInterval(selectedDay.durationSecond - 32400))
    dateFormatter.dateFormat = "mm"
    dailyAccumulationTime = "\(hours)h " + dateFormatter.string(from:formatteddate) + "m"
    
    return dailyAccumulationTime
}
