//
//  UIFont-Config.swift
//  DonateBlood
//
//  Created by Basavaraj Kalaghatagi on 24/04/17.
//  Copyright © 2017 SGS. All rights reserved.
//

import UIKit

extension UIFont {
    
    class func regular(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "WorkSans-Regular", size: size)!
    }
    
    class func Bold(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "WorkSans-Bold", size: size)!
    }
    
    class func Light(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "WorkSans-Light", size: size)!
    }
    
    
}
