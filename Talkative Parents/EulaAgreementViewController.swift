//
//  EulaAgreementViewController.swift
//  Talkative Parents
//
//  Created by Basavaraj Kalaghatagi on 17/05/17.
//  Copyright © 2017 SGS. All rights reserved.
//

import UIKit

class EulaAgreementViewController: UIViewController {
    
    @IBOutlet weak var thisUIAcceptBtn: UIButton!
    
    @IBOutlet weak var thisUIDeclineBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "EULA Agreement"
        Commons.applyCommonBtnRadius(pBtn: thisUIAcceptBtn)
        Commons.applyCommonBtnRadius(pBtn: thisUIDeclineBtn)
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func onTapDeclineBtn(_ sender: Any) {
    }
    
    
    
    @IBAction func onTapAcceptBtn(_ sender: Any) {
        var pVC : MobileLoginViewController!
        pVC = MobileLoginViewController(nibName: "MobileLoginViewController", bundle: nil)
        
        self.navigationController?.pushViewController(pVC, animated: true)
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
