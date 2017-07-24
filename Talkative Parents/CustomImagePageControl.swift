//
//  CustomImagePageControl.swift
//  Talkative Parents
//
//  Created by Basavaraj Kalaghatagi on 16/05/17.
//  Copyright © 2017 SGS. All rights reserved.
//

import UIKit

class CustomImagePageControl: UIPageControl {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    let activeImage:UIImage = UIImage(named: "UIPageControlSelected")!
    let inactiveImage:UIImage = UIImage(named: "UIPageControlUnSelected")!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUp()
    }
    
    func setUp() {
        self.pageIndicatorTintColor = UIColor.clear
        self.currentPageIndicatorTintColor = UIColor.clear
        self.clipsToBounds = false
        updateDots()
    }
    
    func updateDots() {
        var i = 0
        for view in self.subviews {
            if let imageView = self.imageForSubview(view) {
                imageView.removeFromSuperview()
                
                var dotImage = self.inactiveImage
                if i == self.currentPage {
                    dotImage = self.activeImage
                }
                view.clipsToBounds = false
                let bImageView = UIImageView(image:dotImage)
                bImageView.contentMode = .scaleAspectFit
                view.addSubview(bImageView)
                i = i + 1
            } else {
                var dotImage = self.inactiveImage
                if i == self.currentPage {
                    dotImage = self.activeImage
                }
                view.clipsToBounds = false
                view.addSubview(UIImageView(image:dotImage))
                i = i + 1
            }
        }
    }
    
    fileprivate func imageForSubview(_ view:UIView) -> UIImageView? {
        var dot:UIImageView?
        
        if let dotImageView = view as? UIImageView {
            dot = dotImageView
        } else {
            for foundView in view.subviews {
                if let imageView = foundView as? UIImageView {
                    dot = imageView
                    break
                }
            }
        }
        
        return dot
    }

}
