//
//  MoreTabViewController.swift
//  Talkative Parents
//
//  Created by Basavaraj Kalaghatagi on 30/05/17.
//  Copyright © 2017 SGS. All rights reserved.
//

import UIKit

class MoreTabViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var thisUIListTV: UITableView!
    
    private var thisTVData : [OtherObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = Constants.sharedInstance._child.getName()
        // Do any additional setup after loading the view.
        setUpTableView()
        addDashboardBtn()
    }
    
    private func addDashboardBtn() {
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage.init(named: "dashboardIcon"), for: UIControlState.normal)
        button.addTarget(self, action:#selector(self.gotoDashBoard), for: UIControlEvents.touchUpInside)
        button.frame = CGRect.init(x: 0, y: 0, width: 30, height: 30) //CGRectMake(0, 0, 30, 30)
        let barButton = UIBarButtonItem.init(customView: button)
        self.navigationItem.leftBarButtonItem = barButton
    }
    
    func gotoDashBoard() {
        Commons.gotoDashBoard()
    }

    private func setUpTableView() {
        self.thisUIListTV.register(UINib(nibName: "MoreTabTableViewCell", bundle: nil), forCellReuseIdentifier: "MoreTabTableViewCell")
        
        self.thisUIListTV.tableFooterView = UIView(frame: .zero)
        self.thisTVData.append(OtherObject(pTitle: "Talkative Parents Website", pImageName: "moreWebsite"))
        self.thisTVData.append(OtherObject(pTitle: "Social Media Sharing", pImageName: "moreSocialSharing"))
        self.thisTVData.append(OtherObject(pTitle: "Share this App", pImageName: "moreAppSharing"))
        self.thisTVData.append(OtherObject(pTitle: "Attendance", pImageName: "moreAttendance"))
        self.thisTVData.append(OtherObject(pTitle: "Profile", pImageName: "moreProfile"))
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.thisTVData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : MoreTabTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MoreTabTableViewCell", for: indexPath) as! MoreTabTableViewCell
        
        cell.thisUIImageView.image = thisTVData[indexPath.row]._image!
        
        cell.thisTitle.text = thisTVData[indexPath.row]._title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            UIApplication.shared.openURL(URL(string: "http://talkativeparents.com")!)
        }
        else if indexPath.row == 1 {
            let bVC = SocialSharingViewController(nibName: "SocialSharingViewController", bundle: nil)
            let backItem = UIBarButtonItem()
            backItem.title = "Back"
            navigationItem.backBarButtonItem = backItem
            self.navigationController?.pushViewController(bVC, animated: true)
        }
        else if indexPath.row == 2 {
            let message = "I just discovered the Talkative Parents iOS app! It's awesome."
            //Set the link to share.
            if let link = NSURL(string: "https://itunes.apple.com/app/id965818096")
            {
                let objectsToShare = [message,link] as [Any]
                let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
                activityVC.excludedActivityTypes = [UIActivityType.airDrop, UIActivityType.addToReadingList, .copyToPasteboard,  .assignToContact, .saveToCameraRoll, .print]
                self.present(activityVC, animated: true, completion: nil)
            }
        }
        
        else if indexPath.row == 3 {
            let bVC : AttendanceViewController = AttendanceViewController(nibName: "AttendanceViewController", bundle: nil)
            let backItem = UIBarButtonItem()
            backItem.title = "Back"
            navigationItem.backBarButtonItem = backItem
            self.navigationController?.pushViewController(bVC, animated: true)
        } else {
            let bVC = ProfileVC()
            self.navigationController?.pushViewController(bVC, animated: true)
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
