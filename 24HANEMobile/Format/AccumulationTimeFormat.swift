//
//  AccumulationTimeFormat.swift
//  24HANEMobile
//
//  Created by Katherine JANG on 11/29/22.
//

import Foundation

func parseAccumulationTime(type: String, date: Int64) -> String {
    var retTime: String
    let formatteddate = Date(timeIntervalSince1970: TimeInterval(date - 32400))
    let dateFormatter = DateFormatter()
    if type == "day"{
        dateFormatter.dateFormat = "H : mm"
        retTime = dateFormatter.string(from: formatteddate)
    } else {
        let hours = date / 3600
        dateFormatter.dateFormat = "mm"
        retTime = "\(hours) : " + dateFormatter.string(from: formatteddate)
    }
    return retTime
}

