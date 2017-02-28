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

    override func awakeFromNib() {
        super.awakeFromNib()
        self.questionLabel?.adjustsFontSizeToFitWidth = true
    }
    
    func setData(question:Question) {
        self.question = question
        self.questionLabel?.text = question.text
//        self.descriptionLabel?.text = survey.surveyDescription
        if let urlString = question.coverImage, let url = URL(string: urlString) {
            self.backgroundImageView?.alpha = CGFloat(question.coverOpacity)
            self.backgroundImageView?.kf.setImage(with: ImageResource(downloadURL: url))
        }
    }

}
