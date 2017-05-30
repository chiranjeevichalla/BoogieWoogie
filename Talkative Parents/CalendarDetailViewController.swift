//
//  CalendarDetailViewController.swift
//  Talkative Parents
//
//  Created by Basavaraj Kalaghatagi on 30/05/17.
//  Copyright © 2017 SGS. All rights reserved.
//

import UIKit
import QuickLook
import Alamofire
import MRProgress

class CalendarDetailViewController: UIViewController {
    
    
    @IBOutlet weak var thisUICalendarTV: UITableView!
    
    var thisCalendarEvent : CalendarEvent!
    
    var thisTableRowsCount = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        self.thisUICalendarTV.register(UINib(nibName: "NoticeBoardDetailHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "NoticeBoardDetailHeaderTableViewCell")
        
        self.thisUICalendarTV.register(UINib(nibName: "NoticeBoardWebViewTableViewCell", bundle: nil), forCellReuseIdentifier: "NoticeBoardWebViewTableViewCell")
        
        self.thisUICalendarTV.register(UINib(nibName: "NoticeBoardAttachmentTableViewCell", bundle: nil), forCellReuseIdentifier: "NoticeBoardAttachmentTableViewCell")
        
        self.thisUICalendarTV.tableFooterView = UIView(frame: .zero)

        // Do any additional setup after loading the view.
        setupTableViewDetails()
        
        
    }
    
    private func setupTableViewDetails() {
        if thisCalendarEvent.getHasAttachment() {
            thisTableRowsCount = 3
        } else {
            thisTableRowsCount = 2
        }
        self.thisUICalendarTV.reloadData()
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

extension CalendarDetailViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.thisTableRowsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            return getSubjectView(indexPath: indexPath)
        }
        else if indexPath.row == 1 {
            return getWebView(indexPath: indexPath)
        }
        else {
            return getAttachmentCell(indexPath: indexPath)
        }
    }
    
    
    private func getSubjectView(indexPath: IndexPath) -> UITableViewCell {
        let cell: NoticeBoardDetailHeaderTableViewCell = self.thisUICalendarTV.dequeueReusableCell(withIdentifier: "NoticeBoardDetailHeaderTableViewCell", for: indexPath) as! NoticeBoardDetailHeaderTableViewCell
        cell.thisUILabelSubject.text = self.thisCalendarEvent.getTitle()
        cell.thisUILabelDate.text = self.thisCalendarEvent.getDisplayDate()
        return cell
    }
    
    
    private func getWebView(indexPath: IndexPath) -> UITableViewCell {
        let cell: NoticeBoardWebViewTableViewCell = self.thisUICalendarTV.dequeueReusableCell(withIdentifier: "NoticeBoardWebViewTableViewCell", for: indexPath) as! NoticeBoardWebViewTableViewCell
        
//        cell.thisUILabelWebcontent.attributedText =  thisNotificationDetail._messageAttributed!
        
        cell.thisUILabelWebcontent.text = self.thisCalendarEvent.getDescription()
        
//        cell.thisUILabelWebcontent.urlLinkTapHandler = { label, url, range in
//            NSLog("URL \(url) tapped")
//        }
        
        return cell
    }
    
    private func getAttachmentCell(indexPath: IndexPath) -> UITableViewCell {
        let cell: NoticeBoardAttachmentTableViewCell = self.thisUICalendarTV.dequeueReusableCell(withIdentifier: "NoticeBoardAttachmentTableViewCell", for: indexPath) as! NoticeBoardAttachmentTableViewCell
        cell.thisUIAttachmentCV.delegate = self
        cell.thisUIAttachmentCV.dataSource = self
        cell.thisUIAttachmentCV.register(UINib(nibName: "AttachmentCollectionViewCell", bundle:nil), forCellWithReuseIdentifier: "AttachmentCollectionViewCell")
        
        cell.thisUIAttachmentCV.reloadData()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //close
        
        self.thisUICalendarTV.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //        return 100
        
        return UITableViewAutomaticDimension
    }
    //
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    
}


extension CalendarDetailViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.thisCalendarEvent != nil && self.thisCalendarEvent.getHasAttachment() {
            return 1
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : AttachmentCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AttachmentCollectionViewCell", for: indexPath) as! AttachmentCollectionViewCell
        let bAttachment = self.thisCalendarEvent.getAttachment()
        
        cell.thisAttachmentName.text = bAttachment.getName()
        cell.thisUIImageView.image = UIImage(named: (bAttachment._docType?.rawValue)!)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
//        self.thisSelectedAttachmentIndex = indexPath.row
        let bAttachment = self.thisCalendarEvent.getAttachment()
        print("didselect item url \(bAttachment.getUrl())")
        
        
//        bCell.thisCircularView.setProgress(0.5, animated: true)
        if !Commons.isFileExist(pFileName: bAttachment.getUrl()) {
//            Commons.showIndicator()
            let bCell = collectionView.cellForItem(at: indexPath) as! AttachmentCollectionViewCell
            bCell.thisCircularView.isHidden = false
            bCell.thisUIImageView.isHidden = true
            let bUrl = Commons.constructUrl(pUrl: bAttachment.getUrl())
            Alamofire.download(bUrl!, to: Commons.getDestination(pFileName: bAttachment.getUrl()))
                .downloadProgress { progress in
                    print("Download Progress: \(progress.fractionCompleted)")
                    bCell.thisCircularView.setProgress(Float(progress.fractionCompleted), animated: true)
                }
                .response { response in
                    print(response)
//                    Commons.hideIndicator()
                    bCell.thisCircularView.isHidden = true
                    bCell.thisUIImageView.isHidden = false
                    if response.error == nil, let imagePath = response.destinationURL?.path {
                        print("response path is \(response.destinationURL)")
                        //                    self.quickLookController.currentPreviewItemIndex = indexPath.row
                        let quickLookController = QLPreviewController()
//                        quickLookController.delegate = self
                        quickLookController.dataSource = self
                        
                        quickLookController.currentPreviewItemIndex = 0
                        //                    self.navigationController?.pushViewController(self.quickLookController, animated: true)
                        self.present(quickLookController, animated: true, completion: nil)
                    }
            }
        } else {
            
            let quickLookController = QLPreviewController()
//            quickLookController.delegate = self
            quickLookController.dataSource = self
            quickLookController.currentPreviewItemIndex = 0
            //            navigationController?.pushViewController(quickLookController, animated: true)
            self.present(quickLookController, animated: true, completion: nil)
        }
       
    }

}


extension CalendarDetailViewController : QLPreviewControllerDataSource {
    
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        if self.thisCalendarEvent != nil {
            return 1//self.thisNotificationDetail._attachments.count
        }
        return 0
    }
    
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        
        let bUrl = self.thisCalendarEvent.getAttachment().getUrl() //self.thisNotificationDetail._attachments[self.thisSelectedAttachmentIndex].getUrl()
        print("preview item at \(bUrl)")
        return Commons.getFileUrlFromDocDirectory(pFileName: bUrl)
        
    }
    
    
}
