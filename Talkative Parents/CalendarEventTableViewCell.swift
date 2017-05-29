//
//  CalendarEventTableViewCell.swift
//  Talkative Parents
//
//  Created by Basavaraj Kalaghatagi on 29/05/17.
//  Copyright © 2017 SGS. All rights reserved.
//

import UIKit

class CalendarEventTableViewCell: UITableViewCell {

    
    @IBOutlet weak var thisUITitleLabel: SemiBoldLabel!
    
    @IBOutlet weak var thisUITimeLabel: RegularLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
