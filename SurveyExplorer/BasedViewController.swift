//
//  BasedViewController.swift
//  SurveyExplorer
//
//  Created by Chavalit Vanasapdamrong on 2/27/2560 BE.
//  Copyright © 2560 Chavalit Vanasapdamrong. All rights reserved.
//

import UIKit

class BasedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(userTokenDidChange), name: NSNotification.Name(rawValue: UserContext.tokenChangedNotificationName), object: nil)
    }
    
    func userTokenDidChange() {}

}
