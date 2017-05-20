//
//  DashboardCollectionViewCell.swift
//  Talkative Parents
//
//  Created by Basavaraj Kalaghatagi on 18/05/17.
//  Copyright © 2017 SGS. All rights reserved.
//

import UIKit

class DashboardCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var thisUIChildName: UILabel!
    
    @IBOutlet weak var thisUISchoolName: UILabel!
    
    @IBOutlet weak var thisUISchoolImage: UIImageView!
    
    @IBOutlet weak var thisUIChildImageContainer: UIView!
    
    @IBOutlet weak var thisUIChildImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        thisUISchoolImage.image = nil
        thisUIChildImageContainer.layer.masksToBounds = true
        thisUIChildImageContainer.layer.cornerRadius = thisUIChildImageContainer.frame.size.width/2
    }

}
