//
//  APICalls.swift
//  24HANEMobile
//
//  Created by Katherine JANG on 11/29/22.
//

import Foundation
import SwiftUI

class APIHandler: ObservableObject {
    @Published var userInfo: mainInfo = mainInfo.sample
    @Published var monthLogs: perMonth = perMonth.sample
    @Published var dayLogs: perDay = perDay.sample
    @Published var accTime: accumationTimes = accumationTimes.sample
    
    func isLogIn(token: String) -> Bool {
        let url = "https://api.24hoursarenotenough.42seoul.kr/user/login/islogin"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = [
            "Authorization" : "Bearer \(token)"
        ]
        var isSignIn = false
        
        URLSession.shared.dataTask(with: request) {(data, response, error) in
            guard let data = data, error == nil else{
                print("error occured [isLogin-task] ")
                return
            }
            if let response = response as? HTTPURLResponse, response.statusCode == 204 {
                    isSignIn = true
            } else {
                isSignIn = false
            }
        }
        return isSignIn
    }
    
    func getUserInfo(token: String, completionHandler: @escaping(Bool, Any) -> Void) {
        let url = "https://api.24hoursarenotenough.42seoul.kr/v1/tag-log/maininfo"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = [
            "Authorization" : "Bearer \(token)"
        ]
        
        let task  =  URLSession.shared.dataTask(with: request) {(data, response, error) in
            guard let data = data, error == nil else{
                print("error occured [getUserInfo-task]")
                return
            }
            guard let response = response as? HTTPURLResponse else {
                print("error [getUserInfo - HTTPURLResponse]")
                return
            }
            if response.statusCode == 200 {
                DispatchQueue.main.async {
                    do{
                        let decodedUserInfo = try JSONDecoder().decode(mainInfo.self, from: data)
                        self.userInfo = decodedUserInfo
                        completionHandler(true, self.userInfo)
                    } catch let error {
                        print("error [getUserInfo \(error)]")
                    }
                }
            } else {
                print("error [getUserInfo] HTTPURLResponse == \(response.statusCode)")
            }
        }
        task.resume()
    }
    
    func getDayLogs(token: String, year: String, month: String, day: String,  completionHandler: @escaping(Bool, Any) -> Void) {
        let url = "https://api.24hoursarenotenough.42seoul.kr/v1/tag-log/perday"
        var components = URLComponents(string: url)
        let year = URLQueryItem(name: "year", value: year)
        let month = URLQueryItem(name: "month", value: month)
        let day = URLQueryItem(name: "day", value: day)
        components?.queryItems = [year, month, day]
        let requrl = components?.url
        var request = URLRequest(url: requrl!)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = [
            "Authorization": "Bearer \(token)"
        ]
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            guard let data = data, error == nil else {
                print("error [getdayLogs - task]")
                return
            }
            guard let response = response as? HTTPURLResponse else {
                print("error [getdayLogs] HTTPURLResponse")
                return
            }
            if response.statusCode == 200 {
                DispatchQueue.main.async {
                    do{
                        let decodedPerDay = try JSONDecoder().decode(perDay.self, from: data)
                        self.dayLogs = decodedPerDay
                        completionHandler(true, self.dayLogs)
                    } catch let error {
                        print("error", error)
                    }
                }
            } else {
                print("error [getdayLogs] HTTPURLResponse == \(response.statusCode)")
            }
        }
        task.resume()
    }
    
    func getMonthLogs(token: String, year: String, month: String, completionHandler: @escaping(Bool, Any) -> Void) {
        let url = "https://api.24hoursarenotenough.42seoul.kr/v1/tag-log/permonth"
        var components = URLComponents(string:url)
        let year = URLQueryItem(name: "year", value: year)
        let month = URLQueryItem(name: "month", value: month)
        components?.queryItems = [year, month]
        let requrl = components?.url
        var request = URLRequest(url: requrl!)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = [
            "Authorization" : "Bearer \(token)"
        ]
        
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            guard let data = data, error == nil else{
                print("error [getMonthLogs - task]")
                return
            }
            guard let response = response as? HTTPURLResponse else {
                print("error HTTPURLResponse")
                return
            }
            if response.statusCode == 200 {
                DispatchQueue.main.async {
                    do {
                        let decodedPerMonth = try JSONDecoder().decode(perMonth.self, from: data)
                        self.monthLogs = decodedPerMonth
                        completionHandler(true, self.monthLogs)
                    } catch let error {
                        print("error", error)
                    }
                }
            } else {
                print("error [getMonthLogs] HTTPURLResponse == \(response.statusCode)")
            }
        }
        task.resume()
    }
    
    func getAccumulationTimes(token: String, completionHandler: @escaping(Bool, Any) -> Void) {
        let url = "https://api.24hoursarenotenough.42seoul.kr/v1/tag-log/accumulationTimes"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = [
            "Authorization" : "Bearer \(token)"
        ]
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            guard let data = data, error == nil else {
                print("error")
                return
            }
            guard let response = response as? HTTPURLResponse else {
                print("error HTTPURLResponse")
                return
            }
            if response.statusCode == 200 {
                DispatchQueue.main.async {
                    do{
                        let decodeaccumationTime = try JSONDecoder().decode(accumationTimes.self, from: data)
                        self.accTime = decodeaccumationTime
                        completionHandler(true, self.accTime)
                    } catch let error {
                        print("error", error)
                    }
                }
            } else {
                print("error [getAccumulationTimes] HTTPURLResponse == \(response.statusCode)")
            }
        }
        task.resume()
    }
}

