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
    
    private func getJsonAsync<T>(_ url: String, type: T.Type) async throws -> T where T : Decodable {
        guard let url = URL(string: url) else {
            fatalError("MissingURL")
        }
        guard let token = UserDefaults.standard.string(forKey: "Token") else {
            fatalError("UnValid Token")
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
        let decodedData =  try JSONDecoder().decode(type.self, from: data)
        return decodedData
    }
    
    @MainActor
    func getAccumulationTime(token: String) async throws {
        accTime = try await getJsonAsync("https://api.24hoursarenotenough.42seoul.kr/v1/tag-log/accumulationTimes", type: accumationTimes.self)
    }
    
    @MainActor
    func getMainInfo(token: String) async throws{
        userInfo = try await getJsonAsync("https://api.24hoursarenotenough.42seoul.kr/v1/tag-log/maininfo", type: mainInfo.self)
    }
    
    @MainActor
    func getMonthLogs(token: String, year: Int, month: Int) async throws {
        var components = URLComponents(string: "https://api.24hoursarenotenough.42seoul.kr/v1/tag-log/permonth")!
        let year = URLQueryItem(name: "year", value: "\(year)")
        let month = URLQueryItem(name: "month", value: "\(month)")
        components.queryItems = [year, month]
        print(components.url!)
        
        monthLogs = try await getJsonAsync(components.url!.absoluteString, type: perMonth.self)
    }
}
