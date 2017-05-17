//
//  MobileLoginViewController.swift
//  Talkative Parents
//
//  Created by Basavaraj Kalaghatagi on 17/05/17.
//  Copyright © 2017 SGS. All rights reserved.
//

import UIKit

class MobileLoginViewController: UIViewController {

    
    @IBOutlet weak var thisUICountryBtn: UIButton!
    
    @IBOutlet weak var thisUIMobileEntryTF: UITextField!
    
    @IBOutlet weak var thisUISubmitBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Commons.applyCommonBtnRadius(pBtn: thisUISubmitBtn)
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Actions
    @IBAction func onTapCountryBtn(_ sender: Any) {
        
    }
    
    @IBAction func onTapSubmitBtn(_ sender: Any) {
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
