//
//  FirstViewController.swift
//  Talkative Parents
//
//  Created by Basavaraj Kalaghatagi on 15/05/17.
//  Copyright © 2017 SGS. All rights reserved.
//

import UIKit
import CoreData
import SugarRecord

class NotificationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var thisUINotificationsTV: UITableView!
    
    
    lazy var db: CoreDataDefaultStorage = {
        let store = CoreDataStore.named("Basic")
        let bundle = Bundle(for: NotificationsViewController.classForCoder())
        let model = CoreDataObjectModel.merged([bundle])
        let defaultStorage = try! CoreDataDefaultStorage(store: store, model: model)
        return defaultStorage
    }()
    
    private var thisNotifications : [Notification] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Constants.sharedInstance._child.getName()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        self.thisUINotificationsTV.register(UINib(nibName: "NotificationTableViewCell", bundle: nil), forCellReuseIdentifier: "NotificationTableViewCell")
        self.thisUINotificationsTV.tableFooterView = UIView(frame: .zero)
        
        getNotifications()
    }
    
    //MARK: TableView Delegates and functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return thisNotifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: NotificationTableViewCell = self.thisUINotificationsTV.dequeueReusableCell(withIdentifier: "NotificationTableViewCell", for: indexPath) as! NotificationTableViewCell
        
        cell.thisUITitle.text = self.thisNotifications[indexPath.row].getSubject()
        
        cell.thisUISubTitle.text = self.thisNotifications[indexPath.row].getDisplayDate()
        
        if self.thisNotifications[indexPath.row].getDidRead() {
            cell.thisUINotificationImage.image = UIImage(named: "notificationRead")
        } else {
            cell.thisUINotificationImage.image = UIImage(named: "notificationUnread")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //close
        self.updateNotification(pId: self.thisNotifications[indexPath.row].getId(), pStatus: "1")
        self.thisNotifications[indexPath.row]._didRead = true
        self.thisUINotificationsTV.reloadRows(at: [indexPath], with: .fade)
        self.thisUINotificationsTV.deselectRow(at: indexPath, animated: true)
    }

    
    //MARK: private functions
    
    fileprivate func getNotifications() {
        AppService.GetSchoolNotifications(pSchoolId: Constants.sharedInstance._child.getSchoolId(), pPageSize: 300) { (pNotifications, result) in
            if result {
                self.thisNotifications = pNotifications
                for bNotification in self.thisNotifications {
                    bNotification._didRead = self.didRead(pId: bNotification.getId())
                }
                self.thisUINotificationsTV.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func didRead(pId: String) -> Bool {
        let predicate: NSPredicate = NSPredicate(format: "id == %@", pId)
        if let bNotification: NotificationDB? = try! db.fetch(FetchRequest<NotificationDB>().filtered(with: predicate)).first {
            if bNotification != nil {
                print("DidREad notification \(bNotification?.didRead)")
                if bNotification?.didRead == "0" {
                    return false
                } else {
                    return true
                }
            } else {
                return false
            }
            
        }
        
        return false
    }
    
    fileprivate func updateNotification(pId: String, pStatus : String) {
        
        do {
            
            try! db.operation { (context, save) throws -> Void in
                let newTask: NotificationDB = try! context.create()
                newTask.id = pId
                newTask.didRead = pStatus
                                    try! context.insert(newTask)
                save()
            }
        }
        catch {
            // There was an error in the operation
            print("Not saved update Notification")
        }
        
//        let predicate: NSPredicate = NSPredicate(format: "id == %@", pId)
//        if let bNotification: NotificationDB? = try! db.fetch(FetchRequest<NotificationDB>().filtered(with: predicate)).first {
//            do {
//                
//                try! db.operation { (context, save) throws -> Void in
////                    let newTask: NotificationDB = try! context.create()
////                    newTask.id = pId
//                    bNotification?.didRead = pStatus
////                    try! context.insert(newTask)
//                    save()
//                }
//            }
//            catch {
//                // There was an error in the operation
//            }
//        }
        
    }


}

