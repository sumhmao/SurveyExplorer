//
//  QuestionCollectionViewCell.swift
//  SurveyExplorer
//
//  Created by Chavalit Vanasapdamrong on 2/28/2560 BE.
//  Copyright © 2560 Chavalit Vanasapdamrong. All rights reserved.
//

import UIKit
import Kingfisher

class QuestionCollectionViewCell: UICollectionViewCell {
    
    static var identifier = "question_collection_view_cell"
    
    private(set) var question: Question?
    
    @IBOutlet weak var backgroundImageView: UIImageView?
    @IBOutlet weak var questionLabel: UILabel?
    @IBOutlet weak var questionAnswerView: QuestionAnswerView?
    @IBOutlet weak var answerHeight: NSLayoutConstraint?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundImageView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backgroundTap)))
        self.questionLabel?.adjustsFontSizeToFitWidth = true
    }
    
    func setData(question:Question) {
        self.question = question
        self.questionLabel?.text = question.text
        self.answerHeight?.constant = question.displayType.viewHeight
        self.questionAnswerView?.initWithType(question.displayType)
        if let urlString = question.coverImage, let url = URL(string: urlString) {
            self.backgroundImageView?.alpha = CGFloat(question.coverOpacity)
            self.backgroundImageView?.kf.setImage(with: ImageResource(downloadURL: url))
        }
    }
    
    func backgroundTap() {
        self.endEditing(true)
    }

}
