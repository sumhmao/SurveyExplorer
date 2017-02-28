//
//  SurveyCollectionViewCell.swift
//  SurveyExplorer
//
//  Created by Chavalit Vanasapdamrong on 2/28/2560 BE.
//  Copyright © 2560 Chavalit Vanasapdamrong. All rights reserved.
//

import UIKit
import Kingfisher

class SurveyCollectionViewCell: UICollectionViewCell {
    
    static var identifier = "survey_collection_view_cell"
    
    weak var delegate: SurveyCollectionViewCellDelegate?
    private(set) var survey: Survey?
    
    @IBOutlet weak var backgroundImageView: UIImageView?
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var descriptionLabel: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.titleLabel?.adjustsFontSizeToFitWidth = true
        self.descriptionLabel?.adjustsFontSizeToFitWidth = true
    }
    
    func setData(survey:Survey) {
        self.survey = survey
        self.titleLabel?.text = survey.title
        self.descriptionLabel?.text = survey.surveyDescription
        if let urlString = survey.coverImage, let url = URL(string: urlString) {
            self.backgroundImageView?.kf.setImage(with: ImageResource(downloadURL: url))
        }
    }
    
    @IBAction func takeSurvey() {
        if let currentData = self.survey {
            self.delegate?.didTapSurvey(currentData)
        }
    }
    
}

protocol SurveyCollectionViewCellDelegate : NSObjectProtocol {
    
    func didTapSurvey(_ survey:Survey)
    
}
