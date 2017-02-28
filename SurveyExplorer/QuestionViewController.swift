//
//  QuestionViewController.swift
//  SurveyExplorer
//
//  Created by Chavalit Vanasapdamrong on 2/28/2560 BE.
//  Copyright © 2560 Chavalit Vanasapdamrong. All rights reserved.
//

import UIKit

class QuestionViewController: BasedViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var survey: Survey?
    
    @IBOutlet weak var collectionView: UICollectionView?
    @IBOutlet weak var pageCountTitle: UILabel?
    @IBOutlet var saveButton: UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = AppTheme.getAppColor(.MainBackground)
        
        guard let _ = self.survey, self.survey?.questions.count ?? 0 > 0  else {
            _ = self.navigationController?.popViewController(animated: true)
            return
        }
        
        let backButton = UIBarButtonItem(image: UIImage(named: "back_white"), style: .plain, target: self, action: #selector(onBack))
        backButton.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationItem.rightBarButtonItem = nil
        
        self.styleCollectionView()
        self.initializeData()
    }
    
    func styleCollectionView() {
        self.collectionView?.register(UINib(nibName: "QuestionCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: QuestionCollectionViewCell.identifier)
    }
    
    func onBack() {
        let refreshAlert = UIAlertController(title: "Leave", message: "Are you sure you want to leave?", preferredStyle: UIAlertControllerStyle.alert)
        refreshAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
            _ = self.navigationController?.popViewController(animated: true)
        }))
        refreshAlert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (action: UIAlertAction!) in
        }))
        present(refreshAlert, animated: true, completion: nil)
    }
    
    func initializeData() {
        if let currentData = self.survey {
            self.title = currentData.title
            self.updatePageNo(currentPage: 1)
        }
    }
    
    @IBAction func submitSurvey() {
        let refreshAlert = UIAlertController(title: "Submit", message: "Submit data?", preferredStyle: UIAlertControllerStyle.alert)
        refreshAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
            _ = self.navigationController?.popViewController(animated: true)
        }))
        refreshAlert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (action: UIAlertAction!) in
        }))
        present(refreshAlert, animated: true, completion: nil)
    }
    
    // MARK: Page Number
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNo = self.collectionView?.pageNo ?? 0
        self.updatePageNo(currentPage: pageNo + 1)
        if (pageNo + 1 == self.survey?.questions.count ?? 0) {
            self.navigationItem.rightBarButtonItem = self.saveButton
        } else {
            self.navigationItem.rightBarButtonItem = nil
        }
    }
    
    func updatePageNo(currentPage:Int) {
        self.pageCountTitle?.text = "\(currentPage) / \(self.survey?.questions.count ?? 0)"
    }
    
    // MARK: UICollectionView Implementation
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height:(collectionView.frame.size.height))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.survey?.questions.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:QuestionCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: QuestionCollectionViewCell.identifier, for: indexPath) as! QuestionCollectionViewCell
        if indexPath.row < self.survey!.questions.count {
            let data = self.survey!.questions[indexPath.row]
            cell.setData(question: data)
        }
        return cell
    }
}

private extension UICollectionView {
    
    var pageNo: Int {
        get {
            let pageWidth = self.frame.size.width
            let currentPage = self.contentOffset.x / pageWidth
            return Int(currentPage)
        }
    }
    
}
