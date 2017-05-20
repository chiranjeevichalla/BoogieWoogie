//
//  RegularLabel.swift
//  Talkative Parents
//
//  Created by Basavaraj Kalaghatagi on 20/05/17.
//  Copyright © 2017 SGS. All rights reserved.
//


import UIKit

class RegularLabel: UILabel {
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    @IBInspectable internal var fontSize:CGFloat = 15
    
    override func awakeFromNib() {
        self.font = UIFont.regular(ofSize: fontSize)
    }
    
    
}
