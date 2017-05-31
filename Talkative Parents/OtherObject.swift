//
//  OtherObject.swift
//  Talkative Parents
//
//  Created by Basavaraj Kalaghatagi on 30/05/17.
//  Copyright © 2017 SGS. All rights reserved.
//

import Foundation
import UIKit

class OtherObject: NSObject {
    
    var _title : String = ""
    var _image : UIImage?
    
    init(pTitle: String, pImageName: String) {
        self._title = pTitle
        self._image = UIImage(named: pImageName)
    }
}
