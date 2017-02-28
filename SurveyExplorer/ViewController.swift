//
//  ViewController.swift
//  SurveyExplorer
//
//  Created by Chavalit Vanasapdamrong on 2/26/2560 BE.
//  Copyright © 2560 Chavalit Vanasapdamrong. All rights reserved.
//

import UIKit

class ViewController: BasedViewController {
    
    var surveys = [Survey]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.refreshData()
    }
    
    override func customizeNavigationBar() {
        super.customizeNavigationBar()
        
    }
    
    override func userTokenDidChange() {
        self.refreshData()
    }
    
    @IBAction func refreshData() {
        self.showSpinnerWithText("Loading data...")
        ApiManager.sharedInstance.getSurveys(completion: { (surveys:[Survey]?, error:String?) in
            
            guard error == nil else {
                if let errorMsg = error {
                    self.showAlertWithText(errorMsg)
                } else {
                    self.hideSpinner()
                }
                return
            }
            
            if let data = surveys {
                self.surveys.removeAll()
                self.surveys.append(contentsOf: data)
            }
            self.hideSpinner()
        })
    }
    
}
