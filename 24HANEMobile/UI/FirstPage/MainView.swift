//
//  MainView.swift
//  24HANEMobile
//
//  Created by Katherine JANG on 11/29/22.
//

import SwiftUI
import Foundation

enum MyError: Error{
    case invalidURLString
    case invalidServerResponse
}

func loadMore() async -> accumationTimes{
    let token = UserDefaults.standard.string(forKey: "Token")
//      let request = URLRequest(url: URL(string: "https://httpbin.org/delay/2")!)
    var request = URLRequest(url: URL(string: "https://api.24hoursarenotenough.42seoul.kr/v1/tag-log/accumulationTimes")!)
    request.httpMethod = "GET"
    request.allHTTPHeaderFields = [
        "Authorization" : "Bearer \(token)"
    ]
    let (data, response) = try! await URLSession.shared.data(for: request)
    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
       return accumationTimes(todayAccumationTime: 0, monthAccumationTime: 0)
    }
    let decodedAccumulationTimes =  try! await JSONDecoder().decode(accumationTimes.self, from: data)
    
    return decodedAccumulationTimes
}

struct MainView: View {
    @State var accTime: accumationTimes
    @Binding var inoutState: Bool
    var body: some View {
        VStack{
//            HeaderView()
//                .refreshable {
//                   accTime = await loadMore()
//                }
//                .frame(height: 80)
            HStack{
                Text("  24HoursAreNotEnough")
                    .font(.system(size: 20, weight: .light, design: .default))
                    .foregroundColor(Color.LogoColor)
                Spacer()
            }
            Spacer(minLength: 0)
            HStack{
                Text("    Today")
                    .font(.system(size: 20, weight: .medium, design: .default))
                    .foregroundColor(Color.textfordata)
                Spacer()
            }
            DailyView(currentTime: accTime.todayAccumationTime)
            Spacer(minLength: 5)
            HStack{
                Text("    Month")
                    .font(.system(size: 20, weight: .medium, design: .default))
                    .foregroundColor(Color.textfordata)
                Spacer()
            }
            MonthlyView(currentTime: accTime.monthAccumationTime)
            Spacer()
        }
    }

}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(accTime: accumationTimes(todayAccumationTime: 0, monthAccumationTime: 0), inoutState: .constant(true))
    }
}
