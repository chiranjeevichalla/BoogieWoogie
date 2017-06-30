//
//  SDBCommentTableViewCell.swift
//  Talkative Parents
//
//  Created by Basavaraj Kalaghatagi on 08/06/17.
//  Copyright © 2017 SGS. All rights reserved.
//

import UIKit

class SDBCommentTableViewCell: UITableViewCell {

    @IBOutlet weak var thisUIAttachmentBtn: UIButton!
    
    @IBOutlet weak var thisUINameLabel: SemiBoldLabel!
    
    @IBOutlet weak var thisUIDateLabel: SemiBoldLabel!
    
    @IBOutlet weak var thisUIDescriptionlabel: RegularLabel!
    
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
