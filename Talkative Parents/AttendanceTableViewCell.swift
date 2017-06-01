//
//  AttendanceTableViewCell.swift
//  Talkative Parents
//
//  Created by Basavaraj Kalaghatagi on 01/06/17.
//  Copyright © 2017 SGS. All rights reserved.
//

import UIKit

class AttendanceTableViewCell: UITableViewCell {

    
    @IBOutlet weak var thisUIHeaderLabel: SemiBoldLabel!
    
    @IBOutlet weak var thisUIMessageLabel: RegularLabel!
    
    
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
