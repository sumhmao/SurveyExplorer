//
//  EmojiRatingView.swift
//  SurveyExplorer
//
//  Created by Chavalit Vanasapdamrong on 3/1/2560 BE.
//  Copyright © 2560 Chavalit Vanasapdamrong. All rights reserved.
//

import UIKit

class EmojiRatingView: UIView {
    
    var emoji: String?
    var allLabels = [UILabel]()
    
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
        if let view = Bundle.main.loadNibNamed("EmojiRatingView", owner: self, options: nil)?.first as? UIView {
            view.frame = bounds
            view.topAnchor.constraint(equalTo: self.topAnchor)
            view.leftAnchor.constraint(equalTo: self.leftAnchor)
            view.rightAnchor.constraint(equalTo: self.rightAnchor)
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            addSubview(view)
            
            for view in view.subviews {
                if view is UILabel {
                    let btn = view as! UILabel
                    self.allLabels.append(btn)
                    btn.adjustsFontSizeToFitWidth = true
                    btn.isUserInteractionEnabled = true
                    btn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(buttonTap(sender:))))
                }
            }
        }
    }
    
    func buttonTap(sender: UITapGestureRecognizer) {
        self.setValue(sender.view?.tag ?? 1)
    }
    
    func setValue(_ value: Int) {
        self.allLabels.forEach { btn in
            btn.adjustsFontSizeToFitWidth = true
            if btn.tag <= value {
                btn.backgroundColor = UIColor.white
                btn.text = self.emoji
            } else {
                btn.backgroundColor = UIColor.lightGray
                btn.text = ""
            }
        }
    }
    
}
