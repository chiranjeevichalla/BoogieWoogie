//
//  ProfileVC.swift
//  Sample
//
//  Created by chiru on 30/06/17.
//  Copyright © 2017 Apollo. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController ,UIScrollViewDelegate{
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var profileNameLbl: UILabel!
    @IBOutlet var scrollView: UIScrollView!

    @IBOutlet var nameLbl: UILabel!
    @IBOutlet var genderLbl: UILabel!
    @IBOutlet var emailLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.height/2
        self.profileImageView.layer.borderWidth = 2
        self.profileImageView.layer.backgroundColor = UIColor.lightGray.cgColor
        
        self.scrollView.delegate = self
       scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: 700)
        setUPUIData()
    }
    
    private func setUPUIData() {
        self.profileNameLbl.text = Constants.sharedInstance._parent.getName()
        self.nameLbl.text = Constants.sharedInstance._parent.getName()
        self.genderLbl.text = Constants.sharedInstance._parent.getGender()
        self.emailLbl.text = Constants.sharedInstance._parent.getEmailAddress()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
