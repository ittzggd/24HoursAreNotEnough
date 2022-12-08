//
//  CalendarView.swift
//  24HANEMobile
//
//  Created by Katherine JANG on 12/1/22.
//

import SwiftUI

struct CalendarView: View {
    var cols: [GridItem] = [
        GridItem(.flexible(), spacing: 4),
        GridItem(.flexible(), spacing: 4),
        GridItem(.flexible(), spacing: 4),
        GridItem(.flexible(), spacing: 4),
        GridItem(.flexible(), spacing: 4),
        GridItem(.flexible(), spacing: 4),
        GridItem(.flexible(), spacing: 4)
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
                HStack{
                    Text("\(today.monthName)")
                        
                    Text("\(today.yearName)")
                    
                }
                .font(.system(size: 20, weight: .semibold, design: .default))
                .foregroundColor(Color.calendarDate)
                
                LazyVGrid(columns: cols, spacing: 4){
                    ForEach((1...42), id: \.self){ dayNum in
                        if (dayNum > (0 + firstDayofMonth) && dayNum < (lastDayofMonth + firstDayofMonth + 1)) {
                            Button(action: {
                                onClick(dayNum - firstDayofMonth)
                            }) {
                                Text("\(dayNum - firstDayofMonth)")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(Color.gray)
                                    .frame(width: 40, height: 40)
                                    .background(logTimeColor[dayNum - firstDayofMonth - 1])
                            }
                        } else {
                            Text("")
                        }
                    }
                }
                .frame(width: 300, height: 300)
                .padding()
            }
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView(logTimeColor: [.white, .white, .white, .checkOutGray, .white, .white, .white, .checkOutGray, .white, .white, .white, .checkOutGray, .firstLevel, .secondLevel, .white, .thirdLevel, .white, .white, .white, .checkOutGray, .white, .white, .white, .checkOutGray, .white, .white, .white, .checkOutGray, .firstLevel, .secondLevel, .white], onClick: {day in})
    }
}
