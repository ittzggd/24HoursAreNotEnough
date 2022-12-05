//
//  tagLogFormat.swift
//  24HANEMobile
//
//  Created by Katherine JANG on 12/2/22.
//

import Foundation

func parsedLog (inoutLog: Array<inOutStamp>) -> Array<tagLog>{
    var inOutLogs: [tagLog] = [tagLog.sample]
    let dateFormatter = DateFormatter()
    let timeFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    timeFormatter.dateFormat = "HH:mm:ss"
    let count = inoutLog.count
    if count == 0 {
        inOutLogs.append(tagLog(inTimeStamp: "태깅", outTimeStamp: "기록이", durationTime: "없어요!", date: ""))
        inOutLogs.removeFirst()
        return inOutLogs
    }
    for idx in 0...(count - 1) {
        let log =  tagLog(inTimeStamp: timeFormatter.string(from:Date(milliseconds: inoutLog[idx].inTimeStamp)),
                          outTimeStamp: timeFormatter.string(from: Date(milliseconds: inoutLog[idx].outTimeStamp)),
                          durationTime: timeFormatter.string(from: Date(milliseconds: inoutLog[idx].durationSecond - 32400)),
                          date: dateFormatter.string(from: Date(milliseconds: inoutLog[idx].inTimeStamp)))
        
        inOutLogs.append(log)
    }
    inOutLogs.removeFirst()
    return (inOutLogs)
}

func filteringInOutStaemp(inOutStamp : Array<inOutStamp>, year: Int, month: Int, day: Int) -> Array<inOutStamp> {
    let date = "\(year)-\(month)-\(day)"
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-d"
    let filteredInOutStamp = inOutStamp.filter{dateFormatter.string(from: Date(milliseconds: $0.inTimeStamp)) == date}
    return filteredInOutStamp
}
