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
        self.refreshData()
    }
    
    override func userTokenDidChange() {
        self.refreshData()
    }
    
    func refreshData() {
        ApiManager.sharedInstance.getSurveys(completion: { (succeed:Bool, surveys:[Survey]?, message:String?) in
            
            guard succeed else {
                if let errorMsg = message {
                    print("Error: " + errorMsg)
                }
                return
            }
            
            if let data = surveys {
                self.surveys.removeAll()
                self.surveys.append(contentsOf: data)
            }
            
        })
    }
    
}
