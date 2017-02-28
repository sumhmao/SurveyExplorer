//
//  AppTheme.swift
//  SurveyExplorer
//
//  Created by Chavalit Vanasapdamrong on 2/28/2560 BE.
//  Copyright © 2560 Chavalit Vanasapdamrong. All rights reserved.
//

import UIKit

enum AppColor : Int {
    case NavyBlue
    case WhiteText
}

class AppTheme: NSObject {

    static func getAppColor(_ color:AppColor) -> UIColor? {
        switch color {
        case .NavyBlue:
            return UIColor.init(red: 0.06, green: 0.07, blue: 0.14, alpha: 1)
        case .WhiteText:
            return UIColor.white
        }
    }
    
}
