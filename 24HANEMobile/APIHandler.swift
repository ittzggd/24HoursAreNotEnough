//
//  APIHandler.swift
//  24HANEMobile
//
//  Created by Katherine JANG on 12/8/22.
//

import Foundation
import SwiftUI

class APIHandler: ObservableObject{
    @Published var userInfo: mainInfo = mainInfo.sample
    @Published var dayLogs: perDay = perDay.sample
    @Published var monthLogs: perMonth = perMonth.sample
    @Published var accTime: accumationTimes = accumationTimes.sample
    
    func isLogIn(token: String) -> Bool {
        let url = "https://api.24hoursarenotenough.42seoul.kr/user/login/islogin"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = [
            "Authorization" : "Bearer \(token)"
        ]
        var isSignIn = false
        let task = URLSession.shared.dataTask(with: request){(data, response, error) in
            guard let _ = data, error == nil else {
                print("error occured [getUserInfo-task]")
                return
            }
            guard let response = response as? HTTPURLResponse else {
                print("error [getUserInfo - HTTPURLResponse]")
                return
            }
            if response.statusCode == 204 {
                    isSignIn = true
            } else {
               isSignIn = false
            }
            
        }.resume()
        return isSignIn
    }
    
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
    func getAccumulationTime() async throws {
        accTime = try await getJsonAsync("https://api.24hoursarenotenough.42seoul.kr/v1/tag-log/accumulationTimes", type: accumationTimes.self)
    }
    
    @MainActor
    func getMainInfo() async throws{
        userInfo = try await getJsonAsync("https://api.24hoursarenotenough.42seoul.kr/v1/tag-log/maininfo", type: mainInfo.self)
    }
    
    @MainActor
    func getMonthLogs(year: Int, month: Int) async throws {
        var components = URLComponents(string: "https://api.24hoursarenotenough.42seoul.kr/v1/tag-log/permonth")!
        let year = URLQueryItem(name: "year", value: "\(year)")
        let month = URLQueryItem(name: "month", value: "\(month)")
        components.queryItems = [year, month]
        print(components.url!)
        
        monthLogs = try await getJsonAsync(components.url!.absoluteString, type: perMonth.self)
    }
}
