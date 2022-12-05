//
//  ColorState.swift
//  24HANEMobile
//
//  Created by Katherine JANG on 11/29/22.
//

import Foundation
import SwiftUI

class CardViewColor{
    var textfordata: Color = .white
    var progressbarText: Color = .white
    var progressColor: Color = .white
    
    func setColor(inOutState: Bool){
        if inOutState == true{
            textfordata = Color.textfordata
            progressbarText = Color.progressbarText
            progressColor = Color.progressbarblue
        } else {
            textfordata = Color.gray
            progressbarText = Color.gray
            progressColor = Color.gray
        }
    }
}
