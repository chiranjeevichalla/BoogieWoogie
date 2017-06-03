//
//  CreateSoundingBoardMessageViewController.swift
//  Talkative Parents
//
//  Created by Basavaraj Kalaghatagi on 03/06/17.
//  Copyright © 2017 SGS. All rights reserved.
//

import UIKit
import Eureka

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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUPForm()
        let btn1 = UIButton(type: .custom)
        btn1.setImage(UIImage(named: "attachmentNavigationBar"), for: .normal)
        btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn1.addTarget(self, action: #selector(self.attachFile), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: btn1)
        self.navigationItem.setRightBarButtonItems([item1], animated: true)

    }
    
    func attachFile() {
        print("attach the file here")
        getAttachmentImage()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            print("got the image")
            
        }
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
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
                self.imagePicker.cameraCaptureMode = .photo
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
                        
                    }else {
                        if let bCategory = row.value as? Category1 {
                            
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
                    }else {
                        
                        cell.textView.textColor = Constants.sharedInstance.barColor
                    }
                    
                    
                }).cellSetup { cell, row in
                    row.tag = "messageRow"
                    cell.textView.textColor = Constants.sharedInstance.barColor
                    
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
