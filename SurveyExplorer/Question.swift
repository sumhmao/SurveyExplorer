//
//  Question.swift
//  SurveyExplorer
//
//  Created by Chavalit Vanasapdamrong on 2/27/2560 BE.
//  Copyright © 2560 Chavalit Vanasapdamrong. All rights reserved.
//

import UIKit
import SwiftyJSON

enum DisplayType :String{
    
    case intro = "intro"
    case star = "star"
    case heart = "heart"
    case smiley = "smiley"
    case choice = "choice"
    case nps = "nps"
    case textarea = "textarea"
    case textfield = "textfield"
    case outro = "outro"
    
    static func fromString(_ stringValue:String?) -> DisplayType {
        guard let value = stringValue else {
            print("question display type is nil")
            return .choice
        }
        
        if let type = DisplayType(rawValue: value) {
            return type
        }
        return .choice
    }
    
    var viewHeight: CGFloat {
        get {
            switch self {
            case .intro, .nps, .outro, .choice:
                return 0
            case .star, .heart, .smiley:
                return 50
            case .textfield:
                return 50
            case .textarea:
                return 128
            }
        }
    }
}

class Question: NSObject {
    
    private(set) var id:String
    private(set) var text:String
    private(set) var shortText:String?
    private(set) var coverImageThumbnail:String?
    private(set) var coverOpacity:Float
    private(set) var displayType:DisplayType = .choice
    
    var coverImage:String? {
        get {
            if let cover = self.coverImageThumbnail {
                return cover + "l"
            }
            return nil
        }
    }
    
    init?(json:JSON) {
        if let id = json["id"].string,
            let text = json["text"].string {
            self.id = id
            self.text = text
            self.shortText = json["short_text"].string
            self.coverImageThumbnail = json["cover_image_url"].string
            self.coverOpacity = json["cover_image_opacity"].floatValue
            self.displayType = DisplayType.fromString(json["display_type"].string)
            super.init()
        } else {
            return nil
        }
    }
    
}
