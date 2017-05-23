//
//  NWebViewTableViewCell.swift
//  Talkative Parents
//
//  Created by Basavaraj Kalaghatagi on 23/05/17.
//  Copyright © 2017 SGS. All rights reserved.
//

import UIKit

class NWebViewTableViewCell: UITableViewCell {

    @IBOutlet weak var thisUIWebView: UIWebView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
