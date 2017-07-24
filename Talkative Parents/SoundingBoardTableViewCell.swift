//
//  SoundingBoardTableViewCell.swift
//  Talkative Parents
//
//  Created by Basavaraj Kalaghatagi on 02/06/17.
//  Copyright © 2017 SGS. All rights reserved.
//

import UIKit

class SoundingBoardTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var thisUISubjectLabel: SemiBoldLabel!
    
    @IBOutlet weak var thisUISubTitleLabel: RegularLabel!
    
    @IBOutlet weak var thisUIDescriptionLabel: RegularLabel!
    
    
    @IBOutlet weak var thisUICommentImage: UIImageView!
    @IBOutlet weak var thisUICommentsLabel: RegularLabel!
    
    @IBOutlet weak var thisUIAttachmentImage: UIImageView!
    @IBOutlet weak var thisUIAttachmentLabel: RegularLabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
