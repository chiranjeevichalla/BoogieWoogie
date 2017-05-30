//
//  AttachmentCollectionViewCell.swift
//  Talkative Parents
//
//  Created by Basavaraj Kalaghatagi on 23/05/17.
//  Copyright © 2017 SGS. All rights reserved.
//

import UIKit
import MRProgress

class AttachmentCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var thisUIImageView: UIImageView!
    
    @IBOutlet weak var thisAttachmentName: RegularLabel!
    
    @IBOutlet weak var thisCircularView: MRCircularProgressView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
