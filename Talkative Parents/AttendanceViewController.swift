//
//  AttendanceViewController.swift
//  Talkative Parents
//
//  Created by Basavaraj Kalaghatagi on 01/06/17.
//  Copyright © 2017 SGS. All rights reserved.
//

import UIKit
import Firebase

class AttendanceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var thisUIAttendanceTV: UITableView!
    
    private var thisAttendanceList : [Attendance] = []
    
    var thisFIRDBRef : DatabaseReference!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: Bundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = Constants.sharedInstance._child.getName() + " (Attendance)"
        self.thisUIAttendanceTV.register(UINib(nibName: "AttendanceTableViewCell", bundle: nil), forCellReuseIdentifier: "AttendanceTableViewCell")
        
        self.thisUIAttendanceTV.tableFooterView = UIView(frame: .zero)
        // Do any additional setup after loading the view.
        
//        self.navigationItem.hidesBackButton = true
//        let newBackButton = UIBarButtonItem(title: "< Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.back(sender:)))
//        self.navigationItem.leftBarButtonItem = newBackButton
        
        getAttendanceList()
    }
    
    override func didMove(toParentViewController parent: UIViewController?) {
        super.didMove(toParentViewController: parent)
        if parent == nil {
            print("back button pressed")
            if thisFIRDBRef != nil {
                thisFIRDBRef.removeAllObservers()
            }
        }
    }
    
    func back(sender: UIBarButtonItem) {
        print("backbutton")
        if thisFIRDBRef != nil {
            thisFIRDBRef.removeAllObservers()
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    private func getAttendanceList() {
        thisFIRDBRef = FireBaseHelper.GetAttendanceList(callback: { (pNewAttendance, result) in
            self.thisAttendanceList.append(pNewAttendance)
            
            let bIndexPath = NSIndexPath(row: self.thisAttendanceList.count-1, section: 0)
            
            self.thisUIAttendanceTV.insertRows(at: [bIndexPath as IndexPath], with: .bottom)

//            self.thisUIAttendanceTV.reloadData()
        }, callback1: { (pAttendanceList, result) in
            
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.thisAttendanceList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : AttendanceTableViewCell = tableView.dequeueReusableCell(withIdentifier: "AttendanceTableViewCell", for: indexPath) as! AttendanceTableViewCell
        
        cell.thisUIHeaderLabel.text = self.thisAttendanceList[indexPath.row].getCategory()
        cell.thisUIMessageLabel.text = self.thisAttendanceList[indexPath.row].getMessage()
        
        
       // cell.thisUITimeLabel.text = self.thisAttendanceList[indexPath.row].getDate()
        cell.thisUITimeLabel.text = Commons.convertUTCToLocal(pCurrentDate:self.thisAttendanceList[indexPath.row].getDate())
        
        if self.thisAttendanceList[indexPath.row].isPresent() {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
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
    
    deinit {
        print("DEINIT of attendanceviewcontroller")
        if thisFIRDBRef != nil {
            thisFIRDBRef.removeAllObservers()
        }
    }

}
