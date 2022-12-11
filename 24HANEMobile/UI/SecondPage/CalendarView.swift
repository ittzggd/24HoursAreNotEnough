//
//  CalendarView.swift
//  24HANEMobile
//
//  Created by Katherine JANG on 12/1/22.
//

import SwiftUI

struct CalendarView: View {
    var cols: [GridItem] = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]
    var logTimeColor: Array<Color>
    var today = Date()

    
    var firstDayofMonth: Int {
        get{
            return getFirstDateOfMonth(year: today.year, month: today.month)
        }
    }
    
    var lastDayofMonth: Int {
        get{
            return getLastDayOfMonth(year: today.year, month: today.month)
        }
    }
    
    let onClick: (Int) -> Void
                 
    var body: some View {
        ZStack{
            VStack(spacing: -40){
                LazyVGrid(columns: cols, spacing: 6){
                    ForEach((1...42), id: \.self){ dayNum in
                        if (dayNum > (0 + firstDayofMonth) && dayNum < (lastDayofMonth + firstDayofMonth + 1)) {
                            Button(action: {
                                onClick(dayNum - firstDayofMonth)
                            }) {
                                ZStack{
                                    RoundedRectangle(cornerRadius: 5)
                                        .shadow(color: .gray, radius: 2, x: 1, y: 2)
                                    Text("\(dayNum - firstDayofMonth)")
                                        .font(.system(size: 20, weight: .bold))
                                        .foregroundColor((dayNum - firstDayofMonth) <= today.day ? Color.black : Color.futureText)
                                        .frame(width: 40, height: 40)
                                        .background(logTimeColor[dayNum - firstDayofMonth - 1])
                                        .cornerRadius(5)
                                }
                            }
                            .disabled(((dayNum - firstDayofMonth) > today.day) ? true : false)
                        } else {
                            Text("")
                        }
                    }
                }
                .frame(width: 315)
            }
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView(logTimeColor: [.white, .white, .white, .checkOutGray, .white, .white, .white, .checkOutGray, .white, .white, .white, .checkOutGray, .firstLevel, .secondLevel, .white, .thirdLevel, .white, .white, .white, .checkOutGray, .white, .white, .white, .checkOutGray, .white, .white, .white, .checkOutGray, .firstLevel, .secondLevel, .white], onClick: {day in})
    }
}
