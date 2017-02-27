//
//  Survey.swift
//  SurveyExplorer
//
//  Created by Chavalit Vanasapdamrong on 2/26/2560 BE.
//  Copyright © 2560 Chavalit Vanasapdamrong. All rights reserved.
//

import UIKit
import SwiftyJSON

class Survey: NSObject {
    
    private(set) var id:String
    private(set) var title:String
    private(set) var surveyDescription:String
    private(set) var questions = [Question]()
    private(set) var coverImageThumbnail:String?
    
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
            let title = json["title"].string,
            let description = json["description"].string {
            self.id = id
            self.title = title
            self.surveyDescription = description
            self.coverImageThumbnail = json["cover_image_url"].string
            if let questionItems = json["questions"].array {
                for (subJson) in questionItems {
                    if let question = Question(json: subJson) {
                        self.questions.append(question)
                    }
                }
            }
            super.init()
        } else {
            return nil
        }
    }
    
}
