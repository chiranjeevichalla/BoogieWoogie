//
//  MoreTabTableViewCell.swift
//  Talkative Parents
//
//  Created by Basavaraj Kalaghatagi on 30/05/17.
//  Copyright © 2017 SGS. All rights reserved.
//

import UIKit

class MoreTabTableViewCell: UITableViewCell {

    
    @IBOutlet weak var thisUIImageView: UIImageView!
    
    @IBOutlet weak var thisTitle: SemiBoldLabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
