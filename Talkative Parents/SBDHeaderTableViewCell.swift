//
//  SBDHeaderTableViewCell.swift
//  Talkative Parents
//
//  Created by Basavaraj Kalaghatagi on 08/06/17.
//  Copyright © 2017 SGS. All rights reserved.
//

import UIKit

class SBDHeaderTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var thisUITitleLabel: SemiBoldLabel!

    @IBOutlet weak var thisUISubTitleLabel: RegularLabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
