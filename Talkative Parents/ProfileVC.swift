//
//  ProfileVC.swift
//  Sample
//
//  Created by chiru on 30/06/17.
//  Copyright © 2017 Apollo. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController ,UIScrollViewDelegate,
    UIImagePickerControllerDelegate,
UINavigationControllerDelegate{
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var profileNameLbl: UILabel!
    @IBOutlet var scrollView: UIScrollView!

    @IBOutlet var nameLbl: UILabel!
    @IBOutlet var genderLbl: UILabel!
    @IBOutlet var emailLbl: UILabel!
    let picker = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        profileImageView.isUserInteractionEnabled = true
        profileImageView.addGestureRecognizer(tapGestureRecognizer)
        
        self.getImage()
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.height/2
        self.profileImageView.layer.borderWidth = 2
        self.profileImageView.clipsToBounds = true
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
    
    
    func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        
        let alertController = UIAlertController(title:"BoogieWoogie", message: "What would you like to do?", preferredStyle: .actionSheet)
        
        let sendButton = UIAlertAction(title: "PhotoLibrary", style: .default, handler: { (action) -> Void in
                        self.picker.allowsEditing = false
                        self.picker.sourceType = .photoLibrary
                        self.picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            self.present(self.picker,animated: true,completion: nil)

        })
        
        let  deleteButton = UIAlertAction(title: "Camera", style: .default, handler: { (action) -> Void in
                        self.picker.allowsEditing = false
                        self.picker.sourceType = UIImagePickerControllerSourceType.camera
                        self.picker.cameraCaptureMode = .photo
                        self.picker.modalPresentationStyle = .fullScreen
                       self.present(self.picker,animated: true,completion: nil)
        })
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
            print("Cancel button tapped")
        })
        
        
        alertController.addAction(sendButton)
        alertController.addAction(deleteButton)
        alertController.addAction(cancelButton)
        
        self.navigationController!.present(alertController, animated: true, completion: nil)
        
        
        
    }
    //MARK: - Picker Delegates
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated:true, completion: nil)
        
    }
    
func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
        profileImageView.contentMode = .scaleAspectFit //3
        profileImageView.image = chosenImage //4
        
        self.saveImageDocumentDirectory()
        dismiss(animated:true, completion: nil) //5
    }

    
    func saveImageDocumentDirectory(){
        let fileManager = FileManager.default
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("apple.jpg")
//        let image = UIImage(named: "apple.jpg")
        print("Path",paths)
        let imageData = UIImageJPEGRepresentation(profileImageView.image!, 0.5)
        fileManager.createFile(atPath: paths as String, contents: imageData, attributes: nil)
    }
    
    func getDirectoryPath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    func getImage(){
        let fileManager = FileManager.default
        let imagePAth = (self.getDirectoryPath() as NSString).appendingPathComponent("apple.jpg")
        if fileManager.fileExists(atPath: imagePAth){
            self.profileImageView.image = UIImage(contentsOfFile: imagePAth)
        }else{
            print("No Image")
        }
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
