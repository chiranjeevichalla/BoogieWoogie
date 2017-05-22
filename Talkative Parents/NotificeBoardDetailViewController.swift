//
//  NotificeBoardDetailViewController.swift
//  Talkative Parents
//
//  Created by Basavaraj Kalaghatagi on 22/05/17.
//  Copyright © 2017 SGS. All rights reserved.
//

import UIKit

class NotificeBoardDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet weak var thisUINoticeBoardTV: UITableView!
    
    var thisNotification : Notification!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: Bundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.thisUINoticeBoardTV.register(UINib(nibName: "NoticeBoardWebViewTableViewCell", bundle: nil), forCellReuseIdentifier: "NoticeBoardWebViewTableViewCell")
        self.thisUINoticeBoardTV.tableFooterView = UIView(frame: .zero)

        getNotificationDetail()
        // Do any additional setup after loading the view.
    }
    
    fileprivate func getNotificationDetail() {
        AppService.GetNotificationDetail(pNotificationId: thisNotification.getId(), pMessageType: thisNotification.getMessageType()) { (pNotification, result) in
            if(result) {
                
            }
        }
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: NoticeBoardWebViewTableViewCell = self.thisUINoticeBoardTV.dequeueReusableCell(withIdentifier: "NoticeBoardWebViewTableViewCell", for: indexPath) as! NoticeBoardWebViewTableViewCell
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //close
        
        self.thisUINoticeBoardTV.deselectRow(at: indexPath, animated: true)
        
        
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
