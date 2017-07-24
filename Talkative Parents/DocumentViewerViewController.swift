//
//  DocumentViewerViewController.swift
//  Talkative Parents
//
//  Created by Basavaraj Kalaghatagi on 24/05/17.
//  Copyright © 2017 SGS. All rights reserved.
//

import UIKit

class DocumentViewerViewController: UIViewController, UIWebViewDelegate {
    
    
    @IBOutlet weak var thisUIWebView: UIWebView!
    
    
    var thisAttachment : Attachment!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: Bundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadWebView()
        // Do any additional setup after loading the view.
    }

    private func setDownloadbutton() {
        let myimage = UIImage(named: "downloadFile")?.withRenderingMode(.alwaysOriginal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: myimage, style: .plain, target: self, action: #selector(downloadFile))
    }
    
    func downloadFile() {
        print("Button Tapped")
    }
    
    
    private func loadWebView() {
        let bUrl = Commons.constructUrl(pUrl: thisAttachment.getUrl())
        if bUrl != nil {
            let bUrlRequestObject = NSURLRequest(url: bUrl as! URL)
            thisUIWebView.loadRequest(bUrlRequestObject as URLRequest)
            thisUIWebView.scalesPageToFit = true
            thisUIWebView.contentMode = .scaleAspectFit
        }
    }
    
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        Commons.showIndicator()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        Commons.hideIndicator()
        setDownloadbutton()
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
