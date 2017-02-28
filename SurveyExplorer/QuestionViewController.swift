//
//  QuestionViewController.swift
//  SurveyExplorer
//
//  Created by Chavalit Vanasapdamrong on 2/28/2560 BE.
//  Copyright © 2560 Chavalit Vanasapdamrong. All rights reserved.
//

import UIKit

class QuestionViewController: BasedViewController {
    
    var survey: Survey?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let _ = self.survey else {
            _ = self.navigationController?.popViewController(animated: true)
            return
        }
        
        let backButton = UIBarButtonItem(image: UIImage(named: "back_white"), style: .plain, target: self, action: #selector(onBack))
        backButton.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = backButton
        
        self.initializeData()
    }
    
    func onBack() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func initializeData() {
        if let currentData = self.survey {
            self.title = currentData.title
        }
    }
    
}
