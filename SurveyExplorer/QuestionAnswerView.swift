//
//  QuestionAnswerView.swift
//  SurveyExplorer
//
//  Created by Chavalit Vanasapdamrong on 2/28/2560 BE.
//  Copyright © 2560 Chavalit Vanasapdamrong. All rights reserved.
//

import UIKit

class QuestionAnswerView: UIView {
    
    @IBOutlet weak var emojiRatingView: EmojiRatingView?
    
    @IBOutlet weak var textFieldHeight: NSLayoutConstraint?
    @IBOutlet weak var textAreaHeight: NSLayoutConstraint?
    @IBOutlet weak var emojiRatingHeight: NSLayoutConstraint?
    
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
        self.textFieldHeight?.constant = 0
        self.textAreaHeight?.constant = 0
        self.emojiRatingHeight?.constant = 0
        switch type {
        case .textfield:
            self.textFieldHeight?.constant = type.viewHeight
            break
        case .textarea:
            self.textAreaHeight?.constant = type.viewHeight
            break
        case .star:
            self.emojiRatingHeight?.constant = type.viewHeight
            self.emojiRatingView?.emoji = "⭐"
            self.emojiRatingView?.setValue(3)
            break
        case .heart:
            self.emojiRatingHeight?.constant = type.viewHeight
            self.emojiRatingView?.emoji = "❤️️"
            self.emojiRatingView?.setValue(3)
            break
        case .smiley:
            self.emojiRatingHeight?.constant = type.viewHeight
            self.emojiRatingView?.emoji = "😀"
            self.emojiRatingView?.setValue(3)
            break
        default:
            break
        }
    }
    
    func viewHeightWithType(type: DisplayType) -> CGFloat {
        switch type {
        case .intro, .nps, .outro, .choice:
            return 0
        case .star, .heart, .smiley:
            return self.emojiRatingHeight?.constant ?? 0
        case .textfield:
            return self.textFieldHeight?.constant ?? 0
        case .textarea:
            return self.textAreaHeight?.constant ?? 0
        }
    }
    
}
