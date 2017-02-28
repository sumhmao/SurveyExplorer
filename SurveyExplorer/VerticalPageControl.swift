//
//  VerticalPageControl.swift
//  SurveyExplorer
//
//  Created by Chavalit Vanasapdamrong on 3/1/2560 BE.
//  Copyright © 2560 Chavalit Vanasapdamrong. All rights reserved.
//

import UIKit

class VerticalPageControl: UIView {
    
    @IBOutlet private(set) weak var pageControl: UIPageControl?
    
    weak var delegate: VerticalPageControlDelegate?
    
    var currentPage: Int {
        get {
            return self.pageControl?.currentPage ?? 0
        }
        set(value) {
            self.pageControl?.currentPage = value
        }
    }
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        self.initializeView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initializeView()
    }
    
    func initializeView() {
        self.backgroundColor = UIColor.clear
        if let view = Bundle.main.loadNibNamed("VerticalPageControl", owner: self, options: nil)?.first as? UIView {
            view.frame = bounds
            view.topAnchor.constraint(equalTo: self.topAnchor)
            view.leftAnchor.constraint(equalTo: self.leftAnchor)
            view.rightAnchor.constraint(equalTo: self.rightAnchor)
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            addSubview(view)
            self.pageControl?.hidesForSinglePage = true
            self.pageControl?.currentPage = 0
            self.pageControl?.numberOfPages = 0
            self.pageControl?.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        }
    }
    
    func setTotalPageNo(total: Int) {
        self.pageControl?.currentPage = 0
        self.pageControl?.numberOfPages = total
        if let dots = self.pageControl?.subviews {
            for (dot) in dots {
                if let pageDelegate = self.delegate {
                    pageDelegate.stylePageControlDot(dot: dot)
                } else {
                    dot.layer.borderWidth = 1
                    dot.layer.borderColor = UIColor.white.cgColor
                    dot.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                }
            }
        }
    }
    
}

protocol VerticalPageControlDelegate : NSObjectProtocol {
    
    func stylePageControlDot(dot: UIView)
    
}
