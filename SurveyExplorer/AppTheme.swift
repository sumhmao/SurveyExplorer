//
//  AppTheme.swift
//  SurveyExplorer
//
//  Created by Chavalit Vanasapdamrong on 2/28/2560 BE.
//  Copyright © 2560 Chavalit Vanasapdamrong. All rights reserved.
//

import UIKit

enum AppColor : Int {
    case MainBackground
    case NavyBlue
    case WhiteText
}

class AppTheme: NSObject {

    static func getAppColor(_ color:AppColor) -> UIColor? {
        switch color {
        case .MainBackground:
            return UIColor.init(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        case .NavyBlue:
            return UIColor.init(red: 0.06, green: 0.07, blue: 0.14, alpha: 1)
        case .WhiteText:
            return UIColor.white
        }
    }
    
}
