//
//  ProgressCellTableViewCell.swift
//  Talkative Parents
//
//  Created by Basavaraj Kalaghatagi on 05/06/17.
//  Copyright © 2017 SGS. All rights reserved.
//

import UIKit
import Eureka
import MRProgress
import Async

class ProgressCellTableViewCell: Cell<Attachment>, CellType {
    

    @IBOutlet weak var thisUIAttachmentName: RegularLabel!
    
    @IBOutlet weak var thisUIProgressView: MRCircularProgressView!
    
    @IBOutlet weak var thisUIButton: UIButton!
    
    @IBOutlet weak var thisUIImage: UIImageView!
    var thisIsAttached = false
    
    @IBOutlet weak var thisImageWidthConstraint: NSLayoutConstraint!
    
    public override func setup() {
        super.setup()
//        switchControl.addTarget(self, action: #selector(CustomCell.switchValueChanged), for: .valueChanged)
        thisUIButton.addTarget(self, action: #selector(self.HideCell), for: .touchUpInside)
        updateStatus()
        self.thisUIProgressView.isHidden = true
    }
    
     func updateStatus() {
        Async.main {
            self.updateRowValue()
            if self.thisIsAttached {
                
    //            self.thisUIProgressView.isHidden = true
                self.thisUIButton.setImage(UIImage(named: "delete"), for: .normal)
                self.thisUIAttachmentName.text = "Attached"
//                self.thisUIImage.isHidden = false
                self.thisImageWidthConstraint.constant = 40
                UIView.animate(withDuration: 0.5, animations: {
                    self.superview?.layoutIfNeeded()
                })
                
            } else {
    //            self.thisUIProgressView.isHidden = false
                self.thisUIButton.setImage(UIImage(named: "attachment"), for: .normal)
                self.thisUIAttachmentName.text = "No Attachment"
//                self.thisUIImage.isHidden = true
                self.thisImageWidthConstraint.constant = 0
                UIView.animate(withDuration: 0.5, animations: {
                    self.superview?.layoutIfNeeded()
                })
                
            }
            
        }
        
    }
    
    func updateRowValue() {
        if let bAttachment = row.value {
            bAttachment._isAttached = thisIsAttached
        } else {
            row.value = Attachment()
            row.value?._isAttached = thisIsAttached
        }
        
    }
    
    func HideCell(){

        thisIsAttached = !thisIsAttached
        thisUIButton.isSelected = thisIsAttached
        
        if !thisIsAttached {
            updateStatus()
        }
//        updateStatus()
//        self.thisUIAttachmentName.text  = "\(thisIsAttached)"
        row.updateCell() // Re-draws the cell which calls 'update' bellow
    }
    
    
    
    override func didSelect() {
        super.didSelect()
        row.deselect()
    }
    
    public override func update() {
        super.update()
//        backgroundColor = (row.value ?? false) ? .white : .black
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
