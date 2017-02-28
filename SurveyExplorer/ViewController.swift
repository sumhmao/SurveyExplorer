//
//  ViewController.swift
//  SurveyExplorer
//
//  Created by Chavalit Vanasapdamrong on 2/26/2560 BE.
//  Copyright © 2560 Chavalit Vanasapdamrong. All rights reserved.
//

import UIKit

class ViewController: BasedViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView?
    
    var surveys = [Survey]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = AppTheme.getAppColor(.MainBackground)
        self.styleCollectionView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.refreshData()
    }
    
    override func userTokenDidChange() {
        self.refreshData()
    }
    
    func styleCollectionView() {
        self.collectionView?.register(UINib(nibName: "SurveyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: SurveyCollectionViewCell.identifier)
        
    }
    
    @IBAction func refreshData() {
        self.showSpinnerWithText("Refreshing data...")
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
            self.collectionView?.reloadData()
            
            if self.surveys.count > 0 {
                self.collectionView?.scrollToItem(at: IndexPath(row: 0, section: 0),
                                                  at: .top,
                                                  animated: false)
            }
        })
    }
    
    // MARK: UICollectionView Implementation
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height:(collectionView.frame.size.height))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.surveys.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:SurveyCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: SurveyCollectionViewCell.identifier, for: indexPath) as! SurveyCollectionViewCell
        if indexPath.row < self.surveys.count {
            let data = self.surveys[indexPath.row]
            cell.setData(survey: data)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}
