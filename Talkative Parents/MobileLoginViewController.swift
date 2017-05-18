//
//  MobileLoginViewController.swift
//  Talkative Parents
//
//  Created by Basavaraj Kalaghatagi on 17/05/17.
//  Copyright © 2017 SGS. All rights reserved.
//

import UIKit

protocol updateSelectedCountry {
    func setSelectedCountry(pNewSelectedCountry : Country)
}

class MobileLoginViewController: UIViewController, updateSelectedCountry {

    
    @IBOutlet weak var thisUICountryBtn: UIButton!
    
    @IBOutlet weak var thisUIMobileEntryTF: UITextField!
    
    @IBOutlet weak var thisUISubmitBtn: UIButton!
    
    private var thisCountries : [Country] = []
    private var thisSelectedCountry : Country = Country()
    
    var _updateCountryDelegate : updateSelectedCountry!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: Bundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationItem.leftBarButtonItem?.title = "Back"
        self.title = "Mobile Verification"
        Commons.applyCommonBtnRadius(pBtn: thisUISubmitBtn)
        thisSelectedCountry._id = 1
        thisSelectedCountry._name = "India"
        thisSelectedCountry._prefix = "91"
        thisSelectedCountry._showSequence = 1
        
        self._updateCountryDelegate = self
        // Do any additional setup after loading the view.
        
        
    }
    
    // MARK: - Actions
    @IBAction func onTapCountryBtn(_ sender: Any) {
        if thisCountries.count == 0 {
            LookUpService.GetCountries { (countries, result) in
                if result {
                    self.thisCountries = countries
                    self.gotoCountrySelectionPage()
                }
            }
        } else {
            gotoCountrySelectionPage()
        }
    }
    
    @IBAction func onTapSubmitBtn(_ sender: Any) {
        LoginService.Login(pPhoneNumber: thisUIMobileEntryTF.text!, pCountryCode: thisSelectedCountry.getPrefix()) { (result) in
            if result {
                self.gotoOTPPage()
            }
        }
        
    }
    
    // MARK : navigate Functions
    
    private func gotoOTPPage() {
        var pVC : OTPVerificationViewController!
        pVC = OTPVerificationViewController(nibName: "OTPVerificationViewController", bundle: nil)
        pVC.thisPhoneNumber = "\(thisSelectedCountry.getPrefix())\(thisUIMobileEntryTF.text!)"
        self.navigationController?.pushViewController(pVC, animated: true)
    }
    
    private func gotoCountrySelectionPage() {
        var pVC : SelectCountryViewController!
        pVC = SelectCountryViewController(nibName: "SelectCountryViewController", bundle: nil)
        pVC.thisSelectedCountries = self.thisCountries
        pVC.thisSelectedCountry = self.thisSelectedCountry
        pVC.thisCountrySelectionDelegate = self._updateCountryDelegate
        self.navigationController?.pushViewController(pVC, animated: true)
    }
    
    // MARK : protocol to update selected country
    func setSelectedCountry(pNewSelectedCountry: Country) {
        self.thisSelectedCountry = pNewSelectedCountry
        thisUICountryBtn.setTitle(pNewSelectedCountry.getPrefix(), for: .normal)
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
