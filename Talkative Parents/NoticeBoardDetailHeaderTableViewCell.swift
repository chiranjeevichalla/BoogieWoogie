//
//  NoticeBoardDetailHeaderTableViewCell.swift
//  Talkative Parents
//
//  Created by Basavaraj Kalaghatagi on 22/05/17.
//  Copyright © 2017 SGS. All rights reserved.
//

import UIKit

class NoticeBoardDetailHeaderTableViewCell: UITableViewCell {

    
    @IBOutlet weak var thisUILabelSubject: SemiBoldLabel!
    @IBOutlet weak var thisUILabelDate: RegularLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
