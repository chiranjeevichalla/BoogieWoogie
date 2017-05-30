//
//  NotificeBoardDetailViewController.swift
//  Talkative Parents
//
//  Created by Basavaraj Kalaghatagi on 22/05/17.
//  Copyright © 2017 SGS. All rights reserved.
//

import UIKit
import KILabel
import QuickLook
//import AMPPreviewController

import Alamofire

class NotificeBoardDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, QLPreviewControllerDelegate {
    
    
    
    @IBOutlet weak var thisUINoticeBoardTV: UITableView!
    
    var thisNotification : Notification!
    
    var thisNotificationDetail : NotificationDetail!
    
    
    
    
    var thisSelectedAttachmentIndex : Int = 0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: Bundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
    private var thisTableRowsCount = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = thisNotification.getSubject()
        
        self.thisUINoticeBoardTV.register(UINib(nibName: "NoticeBoardWebViewTableViewCell", bundle: nil), forCellReuseIdentifier: "NoticeBoardWebViewTableViewCell")
        
        
        self.thisUINoticeBoardTV.register(UINib(nibName: "NWebViewTableViewCell", bundle: nil), forCellReuseIdentifier: "NWebViewTableViewCell")
        
        self.thisUINoticeBoardTV.register(UINib(nibName: "NoticeBoardDetailHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "NoticeBoardDetailHeaderTableViewCell")
        
        self.thisUINoticeBoardTV.register(UINib(nibName: "NoticeBoardAttachmentTableViewCell", bundle: nil), forCellReuseIdentifier: "NoticeBoardAttachmentTableViewCell")
        
        
        self.thisUINoticeBoardTV.tableFooterView = UIView(frame: .zero)
        getNotificationDetail()
//        quickLookController.dataSource = self
//        quickLookController.delegate = self as! QLPreviewControllerDelegate
        // Do any additional setup after loading the view.
    }
    
    
    
    fileprivate func getNotificationDetail() {
        AppService.GetNotificationDetail(pNotificationId: thisNotification.getId(), pMessageType: thisNotification.getMessageType()) { (pNotification, result) in
            if(result) {
                self.thisNotificationDetail = pNotification!
                if pNotification?._messageAttributed != nil {
                    self.thisTableRowsCount = 2
                    
                    
                }
                if (pNotification?._hasAttachment)! {
                    self.thisTableRowsCount = 3
                }
                self.thisUINoticeBoardTV.reloadData()
                
            }
        }
    }

    
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
        let cell: NoticeBoardDetailHeaderTableViewCell = self.thisUINoticeBoardTV.dequeueReusableCell(withIdentifier: "NoticeBoardDetailHeaderTableViewCell", for: indexPath) as! NoticeBoardDetailHeaderTableViewCell
        cell.thisUILabelSubject.text = thisNotificationDetail.getSubject()
        cell.thisUILabelDate.text = thisNotificationDetail.getDisplayDate()
        return cell
    }
    
    private func getWebView1(indexPath: IndexPath) -> UITableViewCell {
        let cell: NWebViewTableViewCell = self.thisUINoticeBoardTV.dequeueReusableCell(withIdentifier: "NWebViewTableViewCell", for: indexPath) as! NWebViewTableViewCell
        cell.thisUIWebView.loadHTMLString(thisNotificationDetail._message!, baseURL: nil)
        
        return cell
    }
    
    private func getWebView(indexPath: IndexPath) -> UITableViewCell {
        let cell: NoticeBoardWebViewTableViewCell = self.thisUINoticeBoardTV.dequeueReusableCell(withIdentifier: "NoticeBoardWebViewTableViewCell", for: indexPath) as! NoticeBoardWebViewTableViewCell
        
        cell.thisUILabelWebcontent.attributedText =  thisNotificationDetail._messageAttributed!
        
        cell.thisUILabelWebcontent.urlLinkTapHandler = { label, url, range in
            NSLog("URL \(url) tapped")
        }
        
        return cell
    }
    
    private func getAttachmentCell(indexPath: IndexPath) -> UITableViewCell {
        let cell: NoticeBoardAttachmentTableViewCell = self.thisUINoticeBoardTV.dequeueReusableCell(withIdentifier: "NoticeBoardAttachmentTableViewCell", for: indexPath) as! NoticeBoardAttachmentTableViewCell
        cell.thisUIAttachmentCV.delegate = self
        cell.thisUIAttachmentCV.dataSource = self
        cell.thisUIAttachmentCV.register(UINib(nibName: "AttachmentCollectionViewCell", bundle:nil), forCellWithReuseIdentifier: "AttachmentCollectionViewCell")
        
        cell.thisUIAttachmentCV.reloadData()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //close
        
        self.thisUINoticeBoardTV.deselectRow(at: indexPath, animated: true)
        
        
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //        return 100
        
        return UITableViewAutomaticDimension
    }
    //
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
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


extension NotificeBoardDetailViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.thisNotificationDetail != nil {
            return self.thisNotificationDetail._attachments.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : AttachmentCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AttachmentCollectionViewCell", for: indexPath) as! AttachmentCollectionViewCell
        let bAttachment = self.thisNotificationDetail._attachments[indexPath.item]
        
        cell.thisAttachmentName.text = bAttachment.getName()
        cell.thisUIImageView.image = UIImage(named: (bAttachment._docType?.rawValue)!)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        self.thisSelectedAttachmentIndex = indexPath.row
        let bAttachment = self.thisNotificationDetail._attachments[indexPath.item]
        print("didselect item url \(bAttachment.getUrl())")
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
                    bCell.thisCircularView.isHidden = true
                    bCell.thisUIImageView.isHidden = false
//                Commons.hideIndicator()
                if response.error == nil, let imagePath = response.destinationURL?.path {
                    print("response path is \(response.destinationURL)")
//                    self.quickLookController.currentPreviewItemIndex = indexPath.row
                    let quickLookController = QLPreviewController()
                    quickLookController.delegate = self
                    quickLookController.dataSource = self
                    self.thisSelectedAttachmentIndex = indexPath.row
                    quickLookController.currentPreviewItemIndex = 0
//                    self.navigationController?.pushViewController(self.quickLookController, animated: true)
                    self.present(quickLookController, animated: true, completion: nil)
                }
            }
        } else {
//            quickLookController.currentPreviewItemIndex = indexPath.row
            let quickLookController = QLPreviewController()
            quickLookController.delegate = self
            quickLookController.dataSource = self
            quickLookController.currentPreviewItemIndex = 0
//            navigationController?.pushViewController(quickLookController, animated: true)
            self.present(quickLookController, animated: true, completion: nil)
        }
        //QLPreview Controller
//        if QLPreviewController.canPreview(Commons.constructNSUrl(pUrl: self.thisNotificationDetail._attachments[indexPath.item].getUrl())! as QLPreviewItem) {
//            quickLookController.currentPreviewItemIndex = indexPath.row
//            navigationController?.pushViewController(quickLookController, animated: true)
//        }
     
        
        
        //custom view
//        var pVC : DocumentViewerViewController!
//        pVC = DocumentViewerViewController(nibName: "DocumentViewerViewController", bundle: nil)
//        pVC.thisAttachment = self.thisNotificationDetail._attachments[indexPath.item]
//        let backItem = UIBarButtonItem()
//        backItem.title = "Back"
//        navigationItem.backBarButtonItem = backItem
//        self.navigationController?.pushViewController(pVC, animated: true)
        
        //amppreview controller
        
//        let bVC = AMPPreviewController(remoteFile: Commons.constructNSUrl(pUrl: self.thisNotificationDetail._attachments[indexPath.item].getUrl())! as URL!, title: thisNotificationDetail._attachments[indexPath.item].getName())
//        bVC?.startDownloadBlock
//        bVC?.finishDownloadBlock
////        bVC?.finishDownloadBlock{
////            
////        }
//        self.navigationController?.pushViewController(bVC!, animated: true)
        
        //watchtimer
        
//        let bVC = AZAPreviewController()
//        bVC.delegate = self
//        bVC.dataSource = self
//        self.navigationController?.pushViewController(bVC, animated: true)
    }
    
    
    
}

//extension NotificeBoardDetailViewController : AZAPreviewControllerDelegate {
//    func aza_previewController(_ controller: AZAPreviewController!, failedToLoadRemotePreviewItem previewItem: QLPreviewItem!, withError error: Error!) {
//        print("failed to load item \(QLPreviewItem.self)")
//    }
//}

extension NotificeBoardDetailViewController : QLPreviewControllerDataSource {
    
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        if self.thisNotificationDetail != nil {
            return 1//self.thisNotificationDetail._attachments.count
        }
        return 0
    }
    
//    func previewController(controller: QLPreviewController, shouldOpenURL url: NSURL, forPreviewItem item: QLPreviewItem) -> Bool {
//        let bUrl = Commons.constructUrl(pUrl: self.thisNotificationDetail._attachments[index].getUrl())!
//        if bUrl != nil {
//            return true
//        }
//        else {
//            print("Will not open URL \(url.absoluteString)")
//        }
//        
//        return false
//    }
    
    
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
//        let bAttachment = self.thisNotificationDetail._attachments[index]
//        let bUrl = Commons.constructNSUrl(pUrl: self.thisNotificationDetail._attachments[index].getUrl())!
//        
//        let bAZAPreviewItem = AZAPreviewItem(url: bUrl as URL!, title: "title")
//        return bAZAPreviewItem!
//        if Commons.isFileExist(pFileName: self.thisNotificationDetail._attachments[self.thisSelectedAttachmentIndex].getUrl()) {
        let bUrl = self.thisNotificationDetail._attachments[self.thisSelectedAttachmentIndex].getUrl()
        print("preview item at \(bUrl)")
            return Commons.getFileUrlFromDocDirectory(pFileName: bUrl)
//        }
//        else {
////            Commons.showIndicator()
//            let bUrl = Commons.constructUrl(pUrl: bAttachment.getUrl())
//            Alamofire.download(bUrl!, to: Commons.getDestination(pFileName: bAttachment.getUrl()))
//                .downloadProgress { progress in
//                    print("Download Progress: \(progress.fractionCompleted)")
//                }
//                .response { response in
//                    print(response)
////                    Commons.hideIndicator()
//                    if response.error == nil, let imagePath = response.destinationURL?.path {
//                        print("response path is \(response.destinationURL)")
//                        
////                        self.quickLookController.currentPreviewItemIndex = index
//                        
//                        self.quickLookController.refreshCurrentPreviewItem()
////                        self.quickLookController.reloadData()
//                        
//                        
//                    }
//            }
//        }
//        return Commons.constructNSUrl(pUrl: self.thisNotificationDetail._attachments[self.thisSelectedAttachmentIndex].getUrl())! as QLPreviewItem
    }
    
    
}
