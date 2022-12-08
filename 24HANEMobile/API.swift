//
//  API.swift
//  24HANEMobile
//
//  Created by Katherine JANG on 12/8/22.
//

import Foundation
import SwiftUI

class APIHanderTmp: ObservableObject{
    @Published var userInfo: mainInfo = mainInfo.sample
    @Published var dayLogs: perDay = perDay.sample
    @Published var monthLogs: perMonth = perMonth.sample
    @Published var accTime: accumationTimes = accumationTimes.sample
    
    
    func getAccumulationTime(token: String) async throws{
        guard let url = URL(string: "https://api.24hoursarenotenough.42seoul.kr/v1/tag-log/accumulationTimes") else {
            fatalError("MissingURL")
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = [
            "Authorization" : "Bearer \(String(describing: token) )"
        ]
        let (data, response) = try await URLSession.shared.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            fatalError("Access Denied")
        }
        let decodedAccumulationTimes =  try JSONDecoder().decode(accumationTimes.self, from: data)
        accTime = decodedAccumulationTimes
    }
    
    func getMainInfo(token: String) async throws{
        guard let url = URL(string: "https://api.24hoursarenotenough.42seoul.kr/v1/tag-log/maininfo") else {
            fatalError("MissingURL")
        }
        print("Token from getMainInfo: \(token)")
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = [
            "Authorization" : "Bearer \(token)"
        ]
        print("URL: \(url)")
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            fatalError("Access Denied")
        }
        let decodedMainInfo =  try JSONDecoder().decode(mainInfo.self, from: data)
        userInfo = decodedMainInfo
    }
    
    func getMonthLogs(token: String, year: Int, month: Int) async throws {
        var components = URLComponents(string: "https://api.24hoursarenotenough.42seoul.kr/v1/tag-log/permonth")!
        let year = URLQueryItem(name: "year", value: "\(year)")
        let month = URLQueryItem(name: "month", value: "\(month)")
        components.queryItems = [year, month]
        guard let  url = components.url else {
            fatalError("MissingURL")
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = [
            "Authorization" : "Bearer \(String(describing: token) )"
        ]
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            fatalError("Access Denied")
        }
        let decodedPerMonth =  try JSONDecoder().decode(perMonth.self, from: data)
        monthLogs = decodedPerMonth
    }
}
