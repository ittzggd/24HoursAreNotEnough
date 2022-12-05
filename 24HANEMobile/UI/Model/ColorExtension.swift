//
//  ColorExtension.swift
//  24HANEMobile
//
//  Created by Katherine JANG on 11/29/22.
//

import SwiftUI

extension Color{
    static let progressbarblue = Color(hex: "5185C2")
    static let progressbarText = Color(hex:"5A5C57")
    static let logTableBackground = Color(hex: "E0DFDF")
    static let checkInGreen = Color(hex: "03F346")
    static let checkOutGray = Color(hex: "D9D9D9")
    static let firstLevel = Color(hex: "D1EDFA")
    static let secondLevel = Color(hex: "7BD6FF")
    static let thirdLevel = Color(hex : "3FC3FF")
    static let fourthLevel = Color(hex: "0097DC")
    static let cardBackground = Color(hex: "F3F2F9")
    static let textfordata = Color(hex: "1E3C5F")
    static let LogoColor = Color(hex: "1F5390")
    static let calendarDate = Color(hex: "959595")
    
}

extension Color{
    
    init(hex:String){
        let scanner = Scanner(string:hex)
        _ = scanner.scanString("#")
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >> 8) & 0xFF) / 255.0
        let b = Double((rgb >> 0) & 0xFF) / 255.0
        self.init(red: r, green: g, blue:b)
    }
}

