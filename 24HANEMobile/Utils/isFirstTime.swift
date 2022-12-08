//
//  isFirstTime.swift
//  24HANEMobile
//
//  Created by Katherine JANG on 12/8/22.
//

import Foundation

public class Storage{
    static func isFirstTime() {
        let defaults = UserDefaults.standard
        if defaults.object(forKey: "DailySelectionOption") == nil {
            defaults.set(4, forKey: "DailySelectionOption")
            
        }
    }
}
