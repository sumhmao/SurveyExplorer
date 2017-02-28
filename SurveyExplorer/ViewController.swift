//
//  ViewController.swift
//  SurveyExplorer
//
//  Created by Chavalit Vanasapdamrong on 2/26/2560 BE.
//  Copyright © 2560 Chavalit Vanasapdamrong. All rights reserved.
//

import UIKit

class ViewController: BasedViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, SurveyCollectionViewCellDelegate {
    
    @IBOutlet weak var refreshButton: UIBarButtonItem?
    @IBOutlet weak var collectionView: UICollectionView?
    @IBOutlet weak var pageControl: UIPageControl?
    
    var surveys = [Survey]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = AppTheme.getAppColor(.MainBackground)
        self.styleCollectionView()
        self.refreshData()
    }
    
    override func userTokenDidChange() {
        self.refreshData()
    }
    
    func styleCollectionView() {
        self.collectionView?.register(UINib(nibName: "SurveyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: SurveyCollectionViewCell.identifier)
        self.pageControl?.hidesForSinglePage = true
        self.pageControl?.currentPage = 0
        self.pageControl?.numberOfPages = 0
        self.pageControl?.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
    }
    
    @IBAction func refreshData() {
        self.refreshButton?.isEnabled = false
        self.showSpinnerWithText("Refreshing data...")
        ApiManager.sharedInstance.getSurveys(completion: { (surveys:[Survey]?, error:String?) in
            
            guard error == nil else {
                if let errorMsg = error {
                    self.showAlertWithText(errorMsg)
                } else {
                    self.hideSpinner()
                }
                self.refreshButton?.isEnabled = true
                return
            }
            
            if let data = surveys {
                self.surveys.removeAll()
                self.surveys.append(contentsOf: data)
            }
            self.hideSpinner()
            self.refreshButton?.isEnabled = true
            self.collectionView?.reloadData()
            
            if self.surveys.count > 0 {
                self.pageControl?.currentPage = 0
                self.pageControl?.numberOfPages = self.surveys.count
                if let dots = self.pageControl?.subviews {
                    for (dot) in dots {
                        dot.layer.borderWidth = 1
                        dot.layer.borderColor = UIColor.white.cgColor
                        dot.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                    }
                }
                self.collectionView?.scrollToItem(at: IndexPath(row: 0, section: 0),
                                                  at: .top,
                                                  animated: false)
            }
        })
    }
    
    // MARK: PageControl Animation
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageHeight = scrollView.frame.size.height
        let currentPage = scrollView.contentOffset.y / pageHeight
        if (0.0 != fmodf(Float(currentPage), 1.0)) {
            self.pageControl?.currentPage = Int(currentPage) + 1
        }
        else {
            self.pageControl?.currentPage = Int(currentPage)
        }
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
        cell.delegate = self
        if indexPath.row < self.surveys.count {
            let data = self.surveys[indexPath.row]
            cell.setData(survey: data)
        }
        return cell
    }
    
    func didTapSurvey(_ survey: Survey) {
        self.performSegue(withIdentifier: "showSurvey", sender: survey)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSurvey" {
            if let nextVC = segue.destination as? QuestionViewController {
                nextVC.survey = sender as! Survey?
            }
        }
    }
    
}
