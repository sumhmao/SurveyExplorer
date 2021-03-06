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
        self.customizeNavigationBar()
        NotificationCenter.default.addObserver(self, selector: #selector(userTokenDidChange), name: NSNotification.Name(rawValue: UserContext.tokenChangedNotificationName), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(userTokenDidClear), name: NSNotification.Name(rawValue: UserContext.tokenClearedNotificationName), object: nil)
    }
    
    func customizeNavigationBar() {
        navigationController?.navigationBar.barTintColor = AppTheme.getAppColor(.NavyBlue)
        if let titleColor = AppTheme.getAppColor(.WhiteText) {
            navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: titleColor]
        }
    }
    
    func userTokenDidChange() {}
    func userTokenDidClear() {
        self.showAlertWithText("Failed to load data", subtitle: "Tap to hide and try refreshing later")
    }
    
    func showSpinnerWithText(_ spinnerText:String) {
        SwiftSpinner.useContainerView(self.view)
        SwiftSpinner.show(spinnerText)
    }
    
    func showAlertWithText(_ alertText:String, subtitle:String = "Tap to hide") {
        SwiftSpinner.useContainerView(self.view)
        SwiftSpinner.show(alertText, animated: false).addTapHandler({
            self.hideSpinner()
        }, subtitle: subtitle)
    }
    
    func hideSpinner() {
        SwiftSpinner.hide()
    }
    
}
