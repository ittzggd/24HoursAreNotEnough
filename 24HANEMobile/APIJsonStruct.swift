//
//  APIJsonStruct.swift
//  24HANEMobile
//
//  Created by Katherine JANG on 11/29/22.
//

import Foundation

struct mainInfo: Codable{
    let login: String
    let profileImage: String
    let isAdmin: Bool
    let inoutState: String
    
    init(login: String, profileImage: String, isAdmin: Bool, inoutState: String){
        self.login = login
        self.profileImage = profileImage
        self.isAdmin = isAdmin
        self.inoutState = inoutState
    }
    static let sample = mainInfo.init(login: "", profileImage: "", isAdmin: false, inoutState: "")
}

struct perDay: Codable {
    let login: String
    let profileImage: String
    let inOutLogs: [inOutStamp]
    
    init(login: String, profileImage: String, inOutLogs: [inOutStamp]) {
        self.login = login
        self.profileImage = profileImage
        self.inOutLogs = inOutLogs
    }
    static let sample = perDay.init(login: "", profileImage: "", inOutLogs: [])
}

struct perMonth: Codable {
    let login: String
    let profileImage: String
    let inOutLogs: [inOutStamp]
    
    init(login: String, profileImage: String, inOutLogs: [inOutStamp]) {
        self.login = login
        self.profileImage = profileImage
        self.inOutLogs = inOutLogs
    }
    static let sample = perMonth.init(login: "", profileImage: "", inOutLogs: [])
}

struct inOutStamp: Codable{
    let inTimeStamp: Int64
    let outTimeStamp: Int64
    let durationSecond: Int64
    
    init(inTimeStamp: Int64, outTimeStamp: Int64, durationSecond: Int64){
        self.inTimeStamp = inTimeStamp
        self.outTimeStamp = outTimeStamp
        self.durationSecond = durationSecond
    }
    static let sample = inOutStamp.init(inTimeStamp: -1, outTimeStamp: -1, durationSecond: -1)
}

struct accumationTimes: Codable {
    let todayAccumationTime: Int64
    let monthAccumationTime: Int64
    
    init(todayAccumationTime: Int64, monthAccumationTime: Int64){
        self.todayAccumationTime = todayAccumationTime
        self.monthAccumationTime = monthAccumationTime
    }
    static let sample = accumationTimes.init(todayAccumationTime: -1, monthAccumationTime: -1)
}


//taglog가 codable이어야 할 필요가 이
struct tagLog: Identifiable, Codable{
    let id: UUID
    var inTimeStamp: String
    var outTimeStamp: String
    var durationTime: String
    var date: String

    
    init(id: UUID = UUID(), inTimeStamp: String, outTimeStamp: String, durationTime: String, date: String){
        self.id = id
        self.inTimeStamp = inTimeStamp
        self.outTimeStamp = outTimeStamp
        self.durationTime = durationTime
        self.date = date

    }
    static let sample = tagLog(id: UUID() , inTimeStamp: "", outTimeStamp: "", durationTime: "", date: "")
}

struct accTimes: Identifiable, Codable{
    let id: UUID
    var totalAccumulationTime: Int64
    var date: String
    
    init(id: UUID = UUID(), totalAccumulationTime: Int64, date: String){
        self.id = id
        self.totalAccumulationTime = totalAccumulationTime
        self.date = date
    }
}
