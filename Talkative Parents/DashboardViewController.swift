//
//  DashboardViewController.swift
//  Talkative Parents
//
//  Created by Basavaraj Kalaghatagi on 18/05/17.
//  Copyright © 2017 SGS. All rights reserved.
//

import UIKit
import AnimatedCollectionViewLayout
import DZNEmptyDataSet
import OneSignal
class DashboardViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var thisUICollectionView: UICollectionView!
    
    @IBOutlet weak var thisUITableView: UITableView!
    
    @IBOutlet weak var thisUIPageControl1: UIPageControl!
    private var isCVLoaded = false
    private var thisScreenWidth : CGFloat = 0.0
    
    var thisChildrens : [Child] = []
    let imagePicker = UIImagePickerController()
    
    private var thisSelectedProfileImageIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Talkative Parents"
        let myimage = UIImage(named: "refresh1")?.withRenderingMode(.alwaysOriginal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: myimage, style: .plain, target: self, action: #selector(ButtonTapped))

        thisScreenWidth = self.view.bounds.width
        thisUICollectionView.register(UINib(nibName: "DashboardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DashboardCollectionViewCell")
        // Do any additional setup after loading the view.
        getChildrenWithChannels()
        thisUIPageControl1.numberOfPages = 0
        
        self.thisUITableView.register(UINib(nibName: "DashboardTableViewCell", bundle: nil), forCellReuseIdentifier: "DashboardTableViewCell")
        self.thisUITableView.tableFooterView = UIView(frame: .zero)
        self.thisUITableView.emptyDataSetSource = self
        self.thisUITableView.emptyDataSetDelegate = self
        imagePicker.delegate = self
        OneSignal.idsAvailable { (userId, pushToken) in
            if userId != nil {
                print("USER ID \(userId)")
            }
        }
        
        let myimage1 = UIImage(named: "profileNavigation")?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: myimage1, style: .plain, target: self, action: #selector(profileTapped))
        print(Commons.convertUTCToLocal(pCurrentDate: "Thu, 15 Jun 2017 08:10:34 GMT"))
    }
    
    func ButtonTapped() {
        print("Button Tapped")
        getChildrenWithChannels()
    }
    
    func profileTapped() {
        let bVC = ProfileVC()
        self.navigationController?.pushViewController(bVC, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            print("got the image")
            Commons.saveProfileImage(pFileName: self.thisChildrens[self.thisSelectedProfileImageIndex].getChildId(), pImage: image)
            
            self.thisUICollectionView.reloadData()
        }
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func getChildrenWithChannels() {
        ChildrenService.GetChildrenWithChannels { (newChildrens, result) in
            print("found channels")
            if result {
                self.thisChildrens = newChildrens
                self.thisUICollectionView.reloadData()
                self.thisUIPageControl1.numberOfPages = newChildrens.count
                self.thisUIPageControl1.currentPage = 0
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        if isCVLoaded {
           // return
        }
        isCVLoaded = true
        
        /*let layout = AnimatedCollectionViewLayout()
        layout.animator = SnapInAttributesAnimator()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: thisUICollectionView.bounds.width-10 , height: thisUICollectionView.bounds.height)
        let bTop = 63 * thisUICollectionView.bounds.height / 201
        
        layout.sectionInset = UIEdgeInsets(top: -bTop, left: 5, bottom: 0, right: 5)
        
        thisUICollectionView.collectionViewLayout = layout
 */
        
        if let layout = thisUICollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            
            thisScreenWidth = thisUICollectionView.bounds.width
            let bTop = 63 * thisUICollectionView.bounds.height / 201
            
            layout.sectionInset = UIEdgeInsets(top: -bTop, left: 5, bottom: 4, right: 5)
            layout.minimumLineSpacing = 10
            layout.itemSize = CGSize(width: thisUICollectionView.bounds.width-10 , height: thisUICollectionView.bounds.height-5)
            print(thisUICollectionView.bounds.height)
            layout.invalidateLayout()
        }
        
        thisUICollectionView.reloadData()
        
    }
    
    // MARK: Collectionview Delegates & Data Sources
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return thisChildrens.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : DashboardCollectionViewCell = thisUICollectionView.dequeueReusableCell(withReuseIdentifier: "DashboardCollectionViewCell", for: indexPath) as! DashboardCollectionViewCell
        
        cell.layer.cornerRadius = 5
        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.borderWidth = 3
        
        cell.thisUIChildName.text = self.thisChildrens[indexPath.item].getName()+"("+self.thisChildrens[indexPath.item].getBatchName()+")"
        cell.thisUISchoolName.text = self.thisChildrens[indexPath.item].getSchoolName()
        Commons.setImage(pImage: cell.thisUISchoolImage, pUrl: self.thisChildrens[indexPath.item].getSchoolLogo())
        cell.thisUIChildButton.tag = indexPath.item
        cell.thisUIChildButton.addTarget(self, action: #selector(self.getChildImage), for: .touchUpInside)
        
        Commons.setProfileImage(pImageView: cell.thisUIChildImage, pFileName: self.thisChildrens[indexPath.item].getChildId())
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.thisUICollectionView {
            let index = Int(scrollView.contentOffset.x / scrollView.frame.width)
            self.thisUIPageControl1.currentPage = index
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        Constants.sharedInstance._child = self.thisChildrens[indexPath.item]
        
        let appDelegate = UIApplication.shared.delegate! as! AppDelegate
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "tabBarController1")
        appDelegate.window?.rootViewController = initialViewController
        appDelegate.window?.makeKeyAndVisible()
        
    }
    
    func getChildImage(sender: UIButton) {
        print("tag is \(sender.tag)")
        self.thisSelectedProfileImageIndex = sender.tag
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
//
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        self.thisUIPageControl1.currentPage = indexPath.item
//    }

    /*
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let bTop = 63 * thisUICollectionView.bounds.height / 201
        let edgeInsets = (thisScreenWidth - (CGFloat(5) * 50) - (CGFloat(5) * 10)) / 2
        return UIEdgeInsets(top: -bTop, left: edgeInsets, bottom: 0, right: 0)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let leftAndRightPaddings: CGFloat = 15.0
        let numberOfItemsPerRow: CGFloat = CGFloat(2)
        
        let bounds = UIScreen.main.bounds
        let width = (bounds.size.width - leftAndRightPaddings * (numberOfItemsPerRow+1)) / numberOfItemsPerRow
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: collectionView.bounds.height)
        
        return layout.itemSize
    }
     */
    
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

extension DashboardViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : DashboardTableViewCell = tableView.dequeueReusableCell(withIdentifier: "DashboardTableViewCell", for: indexPath) as! DashboardTableViewCell
        
        return cell
    }
}

extension DashboardViewController : DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        var str = "No Data"
        
        
        let attrs = [NSFontAttributeName: UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        var str = "No Pinned Events found"
        
        let attrs = [NSFontAttributeName: UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    //    func buttonTitle(forEmptyDataSet scrollView: UIScrollView, for state: UIControlState) -> NSAttributedString? {
    //        var str = ""
    //
    //        return NSAttributedString(string: str, attributes : nil)
    //    }
    
    func emptyDataSet(_ scrollView: UIScrollView!, didTap view: UIView!) {
        
    }
    
    func emptyDataSet(_ scrollView: UIScrollView, didTap button: UIButton) {
        //        if self._historyType == 0 {
        //
        //        }
        
    }
    
    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
    
    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
    
}


