//
//  NotificationTableViewCell.swift
//  Talkative Parents
//
//  Created by Basavaraj Kalaghatagi on 20/05/17.
//  Copyright © 2017 SGS. All rights reserved.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var thisUINotificationImage: UIImageView!
    
    @IBOutlet weak var thisUITitle: SemiBoldLabel!
    
    @IBOutlet weak var thisUISubTitle: RegularLabel!
    
    @IBOutlet weak var thisUIAttachmentImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
