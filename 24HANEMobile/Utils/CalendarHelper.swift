//
//  CalendarHelper.swift
//  24HANEMobile
//
//  Created by Katherine JANG on 12/1/22.
//

import Foundation
import SwiftUI

func getFirstDateOfMonth(year: Int, month: Int) ->Int {
    let calendar = Calendar.current
    
    let myDateComponents = DateComponents(year: year, month: month)
    
    let startOfMonth = calendar.date(from: myDateComponents)
    let comp1 = calendar.dateComponents([.day, .weekday, .weekOfMonth], from: startOfMonth!)
    
    let nextMonth = calendar.date(byAdding: .month, value:+1, to: startOfMonth!)
    
    if let weekday = comp1.weekday{
        return(weekday - 1)
    }
    return 0
}

func getLastDayOfMonth(year: Int, month: Int) -> Int{
    let calendar = Calendar.current
    
    let myDateComponents = DateComponents(year: year, month: month)
    
    let startOfMonth = calendar.date(from: myDateComponents)
    
    let nextMonth = calendar.date(byAdding: .month, value:+1, to: startOfMonth!)
    
    let endOfMonth = calendar.date(byAdding: .day, value: -1,  to: nextMonth!)
    
    let comp2 = calendar.dateComponents([.day, .weekday, .weekOfMonth], from: endOfMonth!)
    
    return comp2.day!
}

func calculateLogColor(timeLogs: [String: inOutStamp], year: Int, month: Int) -> Array<Color> {
    let lastdayofMonth = getLastDayOfMonth(year: year, month: month)
    var calendarBackGroudColor = [Color](repeating: .checkOutGray, count: lastdayofMonth)
    for idx in (0...(lastdayofMonth - 1)){
        if timeLogs.keys.contains("\(year)-\(month)-\(idx+1)") {
            let accumulationTime: Int64 = timeLogs["\(year)-\(month)-\(idx+1)"]!.durationSecond
            switch accumulationTime{
            case 0 :
                calendarBackGroudColor[idx] = Color.white
            case 1 ... 10800 :
                calendarBackGroudColor[idx] = Color.firstLevel
            case 10801 ... 21600 :
                calendarBackGroudColor[idx] = Color.secondLevel
            case 21601 ... 32400 :
                calendarBackGroudColor[idx] = Color.thirdLevel
            case 32401 ... 43200 :
                calendarBackGroudColor[idx] = Color.fourthLevel
            case 43201 ... 86400 :
                calendarBackGroudColor[idx] = Color.fifthLevel
            default:
                calendarBackGroudColor[idx] = Color.white
            }
        } else {
            calendarBackGroudColor[idx] = idx + 1 <= Date().day ? Color.white : Color.futureBackGround
        }
    }
    return calendarBackGroudColor
}

