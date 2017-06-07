//
//  SoundingBoardDetailViewController.swift
//  Talkative Parents
//
//  Created by Basavaraj Kalaghatagi on 07/06/17.
//  Copyright © 2017 SGS. All rights reserved.
//

import UIKit

class SoundingBoardDetailViewController: UIViewController {

    @IBOutlet weak var inputToolbar: UIView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint! //*** Bottom Constraint of toolbar ***
    @IBOutlet weak var textView: GrowingTextView!
    @IBOutlet weak var thisUIAttachBtn: UIButton!
    
    
    
    private var thisIsAttached = false
    
    private var thisAttachedRotateTo : CGFloat = CGFloat(Double.pi/4)
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        textView.commonInit()
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        // *** Hide keyboard when tapping outside ***
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureHandler))
        view.addGestureRecognizer(tapGesture)
        
        textView.layer.cornerRadius = 5
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func keyboardWillChangeFrame(_ notification: NSNotification) {
        let endFrame = ((notification as NSNotification).userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        bottomConstraint.constant = UIScreen.main.bounds.height - endFrame.origin.y
        self.view.layoutIfNeeded()
    }
    
    func tapGestureHandler() {
        view.endEditing(true)
    }
    
    private func rotateBtnBy() {
        
        if thisIsAttached {
            UIView.animate(withDuration: 0.3, animations: {
                self.thisUIAttachBtn.transform = self.thisUIAttachBtn.transform.rotated(by: self.thisAttachedRotateTo)
            })
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                self.thisUIAttachBtn.transform = self.thisUIAttachBtn.transform.rotated(by: -self.thisAttachedRotateTo)
            })
        }
        
        
    }

    @IBAction func onTapOfAttachmentBtn(_ sender: UIButton) {
//        sender.transform = sender.transform.rotated(by: CGFloat(M_PI_2))
        
        thisIsAttached = !thisIsAttached
        rotateBtnBy()
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
extension SoundingBoardDetailViewController: GrowingTextViewDelegate {
    
    // *** Call layoutIfNeeded on superview for animation when changing height ***
    
    func textViewDidChangeHeight(_ textView: GrowingTextView, height: CGFloat) {
        UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: [.curveLinear], animations: { () -> Void in
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}
