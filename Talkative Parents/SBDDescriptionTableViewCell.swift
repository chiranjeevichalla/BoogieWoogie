//
//  SBDDescriptionTableViewCell.swift
//  Talkative Parents
//
//  Created by Basavaraj Kalaghatagi on 08/06/17.
//  Copyright © 2017 SGS. All rights reserved.
//

import UIKit

class SBDDescriptionTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var thisUIDescriptionLabel: RegularLabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
