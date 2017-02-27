//
//  BasedViewController.swift
//  SurveyExplorer
//
//  Created by Chavalit Vanasapdamrong on 2/27/2560 BE.
//  Copyright © 2560 Chavalit Vanasapdamrong. All rights reserved.
//

import UIKit
import SwiftSpinner

class BasedViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(userTokenDidChange), name: NSNotification.Name(rawValue: UserContext.tokenChangedNotificationName), object: nil)
    }
    
    func userTokenDidChange() {}
    
    func showSpinnerWithText(_ spinnerText:String) {
        SwiftSpinner.useContainerView(self.view)
        SwiftSpinner.show(spinnerText)
    }
    
    func showAlertWithText(_ alertText:String, subtitle:String = "Tap to hide") {
        SwiftSpinner.useContainerView(self.view)
        SwiftSpinner.show(alertText).addTapHandler({
            self.hideSpinner()
        }, subtitle: subtitle)
    }
    
    func hideSpinner() {
        SwiftSpinner.hide()
    }
    
}
