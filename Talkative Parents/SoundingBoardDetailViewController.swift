//
//  SoundingBoardDetailViewController.swift
//  Talkative Parents
//
//  Created by Basavaraj Kalaghatagi on 07/06/17.
//  Copyright © 2017 SGS. All rights reserved.
//

import UIKit
import Firebase

class SoundingBoardDetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var thisUITV: UITableView!
    
    @IBOutlet weak var navigationBar: UINavigationBar!

    @IBOutlet weak var inputToolbar: UIView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint! //*** Bottom Constraint of toolbar ***
    @IBOutlet weak var textView: GrowingTextView!
    @IBOutlet weak var thisUIAttachBtn: UIButton!
    
    @IBOutlet weak var thisUISubmitBtn: UIButton!
    @IBOutlet weak var thisUIAttachedImageLeading: NSLayoutConstraint! //default 10 / 0
    @IBOutlet weak var thisUIAttachedConstraint: NSLayoutConstraint! //default 30 / 0
    @IBOutlet weak var thisUIAttachedImage: UIImageView!
    let imagePicker = UIImagePickerController()
    
    var thisSelectedAttachment : UIImage?
    var thisFileName : String = ""
    
    private var thisIsAttached = false
    
    private var thisAttachedRotateTo : CGFloat = CGFloat(Double.pi/4)
    
    var thisComments : [Comment] = []
    var thisSoundingBoard : SoundingBoard!
    var thisFIRDBRef : FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        // *** Hide keyboard when tapping outside ***
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureHandler))
        view.addGestureRecognizer(tapGesture)
        
        textView.layer.cornerRadius = 10
        
        imagePicker.delegate = self
        self.thisUIAttachedConstraint.constant = 0
        self.thisUIAttachedImageLeading.constant = 0
//        setAttachmentStatus(pStatus: false)
//        rotateBtnBy()
        setUPTableView()
    }
    
    private func setUPTableView() {
        self.thisUITV.register(UINib(nibName: "SBDHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "SBDHeaderTableViewCell")
        
        self.thisUITV.register(UINib(nibName: "SBDDescriptionTableViewCell", bundle: nil), forCellReuseIdentifier: "SBDDescriptionTableViewCell")
        
        self.thisUITV.register(UINib(nibName: "SDBCommentTableViewCell", bundle: nil), forCellReuseIdentifier: "SDBCommentTableViewCell")
        
        self.thisUITV.tableFooterView = UIView(frame: .zero)
        
        self.getComments()
    }
    
    private func getComments() {
        self.thisFIRDBRef = FireBaseHelper.GetSoundingBoardComments(pType: "private", pSoundingBoard: self.thisSoundingBoard, callback: { (pComment, result) in
            if result {
                self.thisComments.append(pComment)
                self.thisUITV.reloadData()
            }
        }) { (pComments, result) in
            
        }
    }
    
    //MARK: deinitialization
    deinit {
        NotificationCenter.default.removeObserver(self)
        print("DEINIT of attendanceviewcontroller")
        if thisFIRDBRef != nil {
            thisFIRDBRef.removeAllObservers()
        }
    }
    
    

    
    //MARK: keyboard notification delegates
    
    func keyboardWillChangeFrame(_ notification: NSNotification) {
        let endFrame = ((notification as NSNotification).userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        bottomConstraint.constant = UIScreen.main.bounds.height - endFrame.origin.y
//        if bottomConstraint.constant < 44 {
  //          bottomConstraint.constant = 44
    //    }
        self.view.layoutIfNeeded()
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            print("Show")
            let bVisibleRows = self.thisUITV.indexPathsForVisibleRows
            if bVisibleRows != nil && (bVisibleRows?.count)! > 0 {
                let bLastRow = bVisibleRows?.last
                if bLastRow != nil {
                    self.thisUITV.scrollToRow(at: bLastRow!, at: .middle, animated: true)
                }
            }
        }
    }
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            print("Hide")
            let bVisibleRows = self.thisUITV.indexPathsForVisibleRows
            if bVisibleRows != nil && (bVisibleRows?.count)! > 0 {
                let bLastRow = bVisibleRows?.last
                if bLastRow != nil {
                    self.thisUITV.scrollToRow(at: bLastRow!, at: .middle, animated: true)
                }
            }
        }
    }
    
    //MARK: gesture
    func tapGestureHandler() {
        view.endEditing(true)
    }
    
    
    //MARK: Image picker delegates
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.dismiss(animated: true, completion: nil)
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            print("got the image")
            self.thisUIAttachedImage.image = image
            self.setAttachmentStatus(pStatus: true)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    //MARK: public functions
    
    func getAttachmentImage() {
        
        
        let alert = UIAlertController(title: nil, message: "Choose the source", preferredStyle: UIAlertControllerStyle.actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
            print("Camera selected")
            //Code for Camera
            //cameraf
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                self.imagePicker.allowsEditing = false
                self.imagePicker.sourceType = UIImagePickerControllerSourceType.camera
                //                self.imagePicker.cameraCaptureMode = .photo
                self.imagePicker.modalPresentationStyle = .fullScreen
                self.present(self.imagePicker,animated: true,completion: nil)
            } else {
                Commons.showErrorMessage(pMessage: "Camera not available/Permission not granted")
            }
        })
        alert.addAction(UIAlertAction(title: "Photo library", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
            print("Photo selected")
            //Code for Photo library
            //photolibaryss
            self.imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
            
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { (result : UIAlertAction) -> Void in
            
            
        })
        
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: Private functions
    
    private func setAttachmentStatus(pStatus : Bool) {
        if thisIsAttached == pStatus {
            return
        }
        thisIsAttached = pStatus
        rotateBtnBy()
    }
    
    private func AttachAttachment(pFileName : String, pImage : UIImage) {
        AppService.UploadFile(pFileName: pFileName, pImage: pImage, pIsProfile: false) { (pImageName, result) in
            
        }
    }
    
    private func rotateBtnBy() {
        
        if thisIsAttached {
            self.thisUIAttachedConstraint.constant = 30
            self.thisUIAttachedImageLeading.constant = 10
            UIView.animate(withDuration: 0.3, animations: {
                self.thisUIAttachBtn.transform = self.thisUIAttachBtn.transform.rotated(by: self.thisAttachedRotateTo)
                self.view.layoutIfNeeded()
            })
        } else {
            self.thisUIAttachedConstraint.constant = 0
            self.thisUIAttachedImageLeading.constant = 0
            UIView.animate(withDuration: 0.3, animations: {
                self.thisUIAttachBtn.transform = self.thisUIAttachBtn.transform.rotated(by: -self.thisAttachedRotateTo)
                self.view.layoutIfNeeded()
            })
        }
    }
    
    
    //MARK: Actions

    @IBAction func onTapOfAttachmentBtn(_ sender: UIButton) {
//        sender.transform = sender.transform.rotated(by: CGFloat(M_PI_2))
        if thisIsAttached {
            setAttachmentStatus(pStatus: false)
        }else {
            getAttachmentImage()
        }
        
    }

    @IBAction func onTapOfBackBtn(_ sender: Any) {
        NotificationCenter.default.removeObserver(self)
        print("DEINIT of SoundingBoarDetailviewcontroller Page")
        if thisFIRDBRef != nil {
            thisFIRDBRef.removeAllObservers()
        }
        self.dismiss(animated: true)
    }
    
    @IBAction func onTapOfSubmitBtn(_ sender: Any) {
        let bText : String = textView.text.trimmingCharacters(in: .whitespacesAndNewlines)
        if bText != "" {
            let bComment = Comment()
            bComment.setMessage(pValue: bText)
            var bImage : UIImage?
            if self.thisIsAttached {
                bImage = thisUIAttachedImage.image
            }
            FireBaseHelper.AddCommentToSoundingBoardMessage(pAttachment: bImage, pComment: bComment, pType: "private", pSoundingBoard: self.thisSoundingBoard, callback: { (result) in
                if result {
                    self.textView.text = ""
                    self.setAttachmentStatus(pStatus: false)
                } else {
                    Commons.showErrorMessage(pMessage: "Something went wrong, Please check internet connection")
                }
            })
            
        }
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

extension SoundingBoardDetailViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2 + self.thisComments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            return getHeaderCell(indexPath: indexPath)
        } else if indexPath.row == 1 {
            return getDescriptionCell(indexPath: indexPath)
        } else {
            return getCommentsCell(indexPath: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //        return 100
        
        return UITableViewAutomaticDimension
    }
    //
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    private func getHeaderCell(indexPath: IndexPath) -> UITableViewCell {
        let cell : SBDHeaderTableViewCell = self.thisUITV.dequeueReusableCell(withIdentifier: "SBDHeaderTableViewCell", for: indexPath) as! SBDHeaderTableViewCell
        
        cell.thisUITitleLabel.text = self.thisSoundingBoard.getSubject()
        cell.thisUISubTitleLabel.text = self.thisSoundingBoard.getDate()
        
        
        return cell
    }
    
    private func getDescriptionCell(indexPath: IndexPath) -> UITableViewCell {
        let cell : SBDDescriptionTableViewCell = self.thisUITV.dequeueReusableCell(withIdentifier: "SBDDescriptionTableViewCell", for: indexPath) as! SBDDescriptionTableViewCell
        
        cell.thisUIDescriptionLabel.text = self.thisSoundingBoard.getDescription()
        
        return cell
    }
    
    private func getCommentsCell(indexPath: IndexPath) -> UITableViewCell {
        let cell : SDBCommentTableViewCell = self.thisUITV.dequeueReusableCell(withIdentifier: "SDBCommentTableViewCell", for: indexPath) as! SDBCommentTableViewCell
        
        let bComment = self.thisComments[indexPath.row-2]
        
        cell.thisUINameLabel.text = bComment.getPostedBy()
        cell.thisUIDateLabel.text = bComment.getPostedDate()
        cell.thisUIDescriptionlabel.text = bComment.getMessage()
        
        if bComment.hasAttachment() {
            cell.thisUIAttachmentImage.isHidden = false
        } else {
            cell.thisUIAttachmentImage.isHidden = true
        }
        
        return cell
    }
}

extension SoundingBoardDetailViewController: GrowingTextViewDelegate {
    
    // *** Call layoutIfNeeded on superview for animation when changing height ***
    
    func textViewDidChangeHeight(_ textView: GrowingTextView, height: CGFloat) {
        UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: [.curveLinear], animations: { () -> Void in
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
        
    func textDidChange(_ textView: GrowingTextView) {
        
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
            self.thisUISubmitBtn.setImage(UIImage(named: "textFieldSubmitBtn"), for: .normal)
        } else {
            self.thisUISubmitBtn.setImage(UIImage(named: "textFieldSubmitBtn1"), for: .normal)
        }
    }
}
