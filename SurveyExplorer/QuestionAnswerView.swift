//
//  QuestionAnswerView.swift
//  SurveyExplorer
//
//  Created by Chavalit Vanasapdamrong on 2/28/2560 BE.
//  Copyright © 2560 Chavalit Vanasapdamrong. All rights reserved.
//

import UIKit

class QuestionAnswerView: UIView {
    
    private(set) var displayType = DisplayType.intro
    
    var viewHeight: CGFloat {
        get {
            switch self.displayType {
            case .intro, .nps, .outro:
                return 0
            case .star, .heart, .smiley, .choice, .textarea, .textfield:
                return 50
            }
        }
    }
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        self.initializeView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initializeView()
    }
    
    func initializeView() {
        self.backgroundColor = UIColor.clear
        if let view = Bundle.main.loadNibNamed("QuestionAnswerView", owner: self, options: nil)?.first as? UIView {
            view.frame = bounds
            view.topAnchor.constraint(equalTo: self.topAnchor)
            view.leftAnchor.constraint(equalTo: self.leftAnchor)
            view.rightAnchor.constraint(equalTo: self.rightAnchor)
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            addSubview(view)
        }
    }
    
    func initWithType(_ type: DisplayType) {
        
    }
    
}
