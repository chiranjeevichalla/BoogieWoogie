//
//  OTPVerificationViewController.swift
//  Talkative Parents
//
//  Created by Basavaraj Kalaghatagi on 17/05/17.
//  Copyright © 2017 SGS. All rights reserved.
//

import UIKit
import Async

class OTPVerificationViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var thisUITF1: UITextField!
    
    @IBOutlet weak var thisUITF2: UITextField!
    
    @IBOutlet weak var thisUITF3: UITextField!
    
    @IBOutlet weak var thisUITF4: UITextField!
    
    @IBOutlet weak var thisUITF5: UITextField!
    
    @IBOutlet weak var thisUITF6: UITextField!
    
    @IBOutlet weak var thisUISubTitleLabel: UILabel!
    
    @IBOutlet weak var thisUIVerifyBtn: UIButton!
    
    
    var thisPhoneNumber: String = ""
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: Bundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Mobile Verification"
        // Do any additional setup after loading the view.
        self.thisUISubTitleLabel.text = "We’ve sent OTP to +\(thisPhoneNumber) via SMS. Please enter the code sent to your mobile."
        setUPTF()
    }
    
    private func setUPTF() {
        thisUITF1.becomeFirstResponder()
        thisUITF1.delegate = self
        thisUITF1.returnKeyType = UIReturnKeyType.next
        thisUITF2.delegate = self
        thisUITF2.returnKeyType = UIReturnKeyType.next
        thisUITF3.delegate = self
        thisUITF3.returnKeyType = UIReturnKeyType.next
        thisUITF4.delegate = self
        thisUITF4.returnKeyType = UIReturnKeyType.next
        thisUITF5.delegate = self
        thisUITF5.returnKeyType = UIReturnKeyType.next
        thisUITF6.delegate = self
        thisUITF6.returnKeyType = UIReturnKeyType.go
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("begin editing")
        textField.text = ""
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textFieldDidChange(textField: textField)
        return true
    }
    
    func textFieldDidChange(textField: UITextField){
        
        //let text = textField.text
        
        //if text?.utf16.count==1{
            switch textField{
            case thisUITF1:
                thisUITF2.becomeFirstResponder()
            case thisUITF2:
                thisUITF3.becomeFirstResponder()
            case thisUITF3:
                thisUITF4.becomeFirstResponder()
            case thisUITF4:
                thisUITF5.becomeFirstResponder()
            case thisUITF5:
                thisUITF6.becomeFirstResponder()
            case thisUITF6:
                thisUITF6.resignFirstResponder()
            default:
                break
            }
        //}else{
            
        //}
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("edited \(string)")
        //textField.text = string
        Async.main(after:
            0.05) {
                self.textFieldDidChange(textField: textField)
        }
        
        return true
    }
    

    
    //MARK: Actions
    
    @IBAction func onTapVerifyBtn(_ sender: Any) {
        if (validateText()) {
            LoginService.Validate(pPhoneNumber: thisPhoneNumber, pOTPCode: getOTP(), callback: { (result) in
                
            })
        }
    }
    
    
    //MARK: private functions
    
    private func getOTP() -> String {
        let bOTP = "\(thisUITF1.text!)\(thisUITF2.text!)\(thisUITF3.text!)\(thisUITF4.text!)\(thisUITF5.text!)\(thisUITF6.text!)"
        return bOTP;
    }
    
    private func validateText() -> Bool {
        if thisUITF1.text == "" || thisUITF2.text == "" || thisUITF3.text == "" || thisUITF4.text == "" || thisUITF5.text == "" || thisUITF6.text == ""{
            return false
        }
        
        return true
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
