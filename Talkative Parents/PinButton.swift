//
//  PinButton.swift
//  Boogie Woogie
//
//  Created by chiru on 25/07/17.
//  Copyright © 2017 SGS. All rights reserved.
//

import UIKit

class PinButton: UIButton {

    let checkedImage = UIImage(named:"calendarPinned")! as UIImage
    let uncheckedImage = UIImage(named:"calendarUnPinned")! as UIImage
    
    // Bool property
    var isChecked: Bool = false {
        didSet{
            if isChecked == true {
                self.setImage(checkedImage, for: UIControlState.normal)
            } else {
                self.setImage(uncheckedImage, for: UIControlState.normal)
            }
        }
    }
    
    override func awakeFromNib() {
        self.addTarget(self, action:#selector(buttonClicked(sender:)), for: UIControlEvents.touchUpInside)
        self.isChecked = false
    }
    
    func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
        }
    }
}
