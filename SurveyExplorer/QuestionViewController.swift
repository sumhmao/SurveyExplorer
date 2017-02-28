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
    @IBOutlet weak var backButton: UIButton?
    @IBOutlet weak var nextButton: UIButton?
    @IBOutlet weak var pageCountTitle: UILabel?
    
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
        
        self.styleCollectionView()
        self.initializeData()
    }
    
    func styleCollectionView() {
        self.collectionView?.register(UINib(nibName: "QuestionCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: QuestionCollectionViewCell.identifier)
    }
    
    func onBack() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func initializeData() {
        if let currentData = self.survey {
            self.title = currentData.title
            self.backButton?.isHidden = true
            if currentData.questions.count <= 1 {
                self.nextButton?.isHidden = true
            }
            self.updatePageNo(currentPage: 1)
        }
    }
    
    @IBAction func previousQuestion() {
        if let pageNo = self.collectionView?.pageNo, (pageNo - 1) >= 0 {
            let to = pageNo - 1
            self.collectionView?.scrollPageFrom(page: pageNo, to: to)
            self.nextButton?.isHidden = false
            if to == 0 {
                self.backButton?.isHidden = true
            }
            self.updatePageNo(currentPage: to + 1)
        }
    }
    
    @IBAction func nextQuestion() {
        if let pageNo = self.collectionView?.pageNo, (pageNo + 1) < (self.survey?.questions.count ?? 0) {
            let to = pageNo + 1
            self.collectionView?.scrollPageFrom(page: pageNo, to: to)
            self.backButton?.isHidden = false
            if to == ((self.survey?.questions.count ?? 0) - 1) {
                self.nextButton?.isHidden = true
            }
            self.updatePageNo(currentPage: to + 1)
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
    
    func scrollPageFrom(page from:Int, to:Int) {
        self.scrollToItem(at: IndexPath(row: to, section: 0),
                          at: (from < to ? .left : .right),
                          animated: true)
    }
    
}
