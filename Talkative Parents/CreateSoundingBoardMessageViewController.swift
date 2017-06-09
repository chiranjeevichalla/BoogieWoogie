//
//  CreateSoundingBoardMessageViewController.swift
//  Talkative Parents
//
//  Created by Basavaraj Kalaghatagi on 03/06/17.
//  Copyright © 2017 SGS. All rights reserved.
//

import UIKit
import Eureka
import Async

final class ProgressRow: Row<ProgressCellTableViewCell>, RowType {
    required public init(tag: String?) {
        super.init(tag: tag)
        // We set the cellProvider to load the .xib corresponding to our cell
        cellProvider = CellProvider<ProgressCellTableViewCell>(nibName: "ProgressCellTableViewCell")
    }
}

final class CategorySelectionRow : SelectorRow<PushSelectorCell<Category1>, CategorySelectionViewController>, RowType {
    public required init(tag: String?) {
        super.init(tag: tag)
        presentationMode = .show(controllerProvider: ControllerProvider.callback { return CategorySelectionViewController(){ _ in } }, onDismiss: { vc in _ = vc.navigationController?.popViewController(animated: true) })
        
        displayValueFor = {
            guard let category = $0 else { return "" }
            //            let fmt = NumberFormatter()
            //            fmt.maximumFractionDigits = 4
            //            fmt.minimumFractionDigits = 4
            //            let latitude = fmt.string(from: NSNumber(value: location.coordinate.latitude))!
            //            let longitude = fmt.string(from: NSNumber(value: location.coordinate.longitude))!
            return category.getName()
        }
    }
}


class CreateSoundingBoardMessageViewController: FormViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var bAttachmentRow : BaseRow!
    
    let imagePicker = UIImagePickerController()
    
    var thisSelectedAttachment : UIImage?
    var thisFileName : String = ""
    
    let thisSoundingBoardMessage = SoundingBoard()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "New Message"

        // Do any additional setup after loading the view.
        setUPForm()
        let btn1 = UIButton(type: .custom)
        btn1.setImage(UIImage(named: "attachmentNavigationBar"), for: .normal)
        btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn1.addTarget(self, action: #selector(self.attachFile), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: btn1)
        self.navigationItem.setRightBarButtonItems([item1], animated: true)
        
        imagePicker.delegate = self

    }
    
    func attachFile() {
        print("attach the file here")
        getAttachmentImage()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.dismiss(animated: true, completion: nil)
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            print("got the image")
            if let row = form.rowBy(tag: "ProgressRow") as? ProgressRow {
                self.thisSelectedAttachment = image
                self.thisFileName = Commons.getUniqueStringId()
                row.cell.thisIsAttached = true
                row.cell.thisUIAttachmentName.text =  "Attached"
                row.cell.updateStatus()
                row.cell.thisUIImage.image = image
//                row.hidden = Condition.function(["ProgressRow"], { form in
//                    return !row.cell.thisIsAttached
//                })
            }
        }
    }
    
    private func AttachAttachment(pFileName : String, pImage : UIImage) {
        AppService.UploadFile(pFileName: pFileName, pImage: pImage, pIsProfile: false) { (pImageName, result) in
            
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
        if let row = form.rowBy(tag: "ProgressRow") as? ProgressRow {
            
            row.cell.thisUIAttachmentName.text =  "No Attachment"
            row.cell.thisIsAttached = false
            row.cell.updateStatus()
            
        }
    }
    
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
            if let row = self.form.rowBy(tag: "ProgressRow") as? ProgressRow {
                
                row.cell.thisUIAttachmentName.text =  "No Attachment"
                row.cell.thisIsAttached = false
                row.cell.updateStatus()
            }

        })
        
        self.present(alert, animated: true, completion: nil)
    }



    
    private func setUPForm() {
        
        self.tableView.separatorColor = Constants.sharedInstance.barColor
        
        var rules1 = RuleSet<String>()
        rules1.add(rule: RuleRequired())
        rules1.add(rule: RuleMaxLength(maxLength: 100, msg: "Max 100 Characters"))
        
        var rules2 = RuleSet<String>()
        rules2.add(rule: RuleRequired())
        rules2.add(rule: RuleMaxLength(maxLength: 160, msg: "Max 100 Characters"))
        
        
        
        
        
        form
            
            +++ CategorySelectionRow(){
                $0.title = "Send Message To"
                
                $0.add(rule: RuleRequired())
                }.cellSetup { cell, row in
                    cell.textLabel?.textColor = Constants.sharedInstance.barColor
                }.cellUpdate({ (cell, row) in
                    
                    if !row.isValid {
//                        cell.titleLabel?.textColor = UIColor.red
                        
                    }else {
                        if let bCategory = row.value as? Category1 {
                            self.thisSoundingBoardMessage.setCategoryName(pValue: bCategory.getName())
                            self.thisSoundingBoardMessage.setCategoryKey(pValue: bCategory.getKey())
                        }
                    }
                    
                    
                    //                    if let address = cell as Address1 {
                    //                        
                    //                    }
                })


            <<< TextRow(){ row in
                row.tag = "subjectRow"
                row.title = "Subject"
                row.placeholder = "Enter the subject"
//                row.add(rule: RuleRequired())
                row.add(ruleSet: rules1)
                row.validationOptions = .validatesOnChange
                
                }.cellUpdate({ (cell, row) in
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }else {
                        if let bValue = row.value {
                            self.thisSoundingBoardMessage.setSubject(pValue: bValue)
                        }
                        
                    }
                }).cellSetup({ (cell, row) in
                    
                })
            <<< TextAreaRow() {
                row in
                row.tag = "messageRow"
                row.title = "TextArearow"
                row.placeholder = "Enter the Message (Max 160 characters)"
                row.add(ruleSet: rules2)
                row.validationOptions = .validatesOnChange
                
                }.cellUpdate({ (cell, row) in
                    if !row.isValid {
                        print("max length reached")
                        cell.textView.textColor = UIColor.red
                        cell.placeholderLabel?.textColor = UIColor.red
                    }else {
                        if let bValue = row.value {
                            self.thisSoundingBoardMessage.setDescription(pValue: bValue)
                        }
                        cell.textView.textColor = Constants.sharedInstance.barColor
                    }
                    
                    
                }).cellSetup { cell, row in
                    row.tag = "messageRow"
                    cell.textView.textColor = Constants.sharedInstance.barColor
                    
                }
        
            <<< ProgressRow() { row in
                row.tag = "ProgressRow"
                row.value?._isAttached = false
                row.cell.height =  {100}
//                row.hidden = Condition.function(["ProgressRow"], { form in
//                    return !row.cell.thisIsAttached
//                })
                }.cellUpdate({ (cell, row) in
                    print("on change called ")
                    if cell.thisIsAttached {
                        self.getAttachmentImage()
                    } else {
                        
                    }
                    if let bAttachment = row.value {
                        if bAttachment._isAttached {
                            print("attached")
//                            self.getAttachmentImage()
                        } else {
                            print("not attached")
                        }
                    }
                    
                    
                })
        
            <<< ButtonRow() { row in
                row.title = "Send Message"
//                row.cell.height =  {100}
                row.cell.tintColor = UIColor.white
                row.cell.backgroundColor = UIColor(red: 83/255, green: 186/255, blue: 209/255, alpha: 1.0)
                }.onCellSelection({ (cell, row) in
                    print("On button selection")
                    let errors = self.form.validate()
                    
                    print("errors count \(errors.count)")
                    if errors.count == 0 {
                        
                        if let row1 = self.form.rowBy(tag: "ProgressRow") as? ProgressRow {
                            
//                            row.cell.thisIsAttached = true
//                            row.cell.thisUIImage.image = image
                            //                row.hidden = Condition.function(["ProgressRow"], { form in
                            //                    return !row.cell.thisIsAttached
                            //                })
                            var bImage : UIImage?
                            if row1.cell.thisIsAttached {
                                bImage = row1.cell.thisUIImage.image
                            }
                            FireBaseHelper.AddSoundingBoardMessage(pAttachment: bImage, pMessage: self.thisSoundingBoardMessage, pType: "private", callback: { (result) in
                                if result {
                                    self.navigationController?.popViewController(animated: true)
                                }
                            })

                        }
                        
                   }
                    
                })
    
//        Async.main(after: 5.0) {
//            if let progressrow = self.form.rowBy(tag: "ProgressRow") as? ProgressRow {
//                progressrow.value?._isAttached = true
//            }
//        }
        
        
    
        
        
        
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
