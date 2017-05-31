//
//  SocialSharingViewController.swift
//  Talkative Parents
//
//  Created by Basavaraj Kalaghatagi on 31/05/17.
//  Copyright © 2017 SGS. All rights reserved.
//

import UIKit

class SocialSharingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var thisUITV: UITableView!
    
    private var thisTVData : [OtherObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        self.title = "Social Media Sharing"
        // Do any additional setup after loading the view.
    }
    
    private func setUpTableView() {
        
        self.thisUITV.register(UINib(nibName: "MoreTabTableViewCell", bundle: nil), forCellReuseIdentifier: "MoreTabTableViewCell")
        
        self.thisUITV.tableFooterView = UIView(frame: .zero)
        self.thisTVData.append(OtherObject(pTitle: "Facebook", pImageName: "moreFBIcon"))
        self.thisTVData.append(OtherObject(pTitle: "Twitter", pImageName: "moreTwitterIcon"))
        self.thisTVData.append(OtherObject(pTitle: "LinkedIn", pImageName: "moreLinkedInIcon"))

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
        var bUrl = ""
        if indexPath.row == 0 {
            bUrl = "https://www.facebook.com/talkativeparents/"
        } else if indexPath.row == 1 {
            bUrl = "https://twitter.com/gettalkativeTP"
        } else {
            bUrl = "https://www.linkedin.com/company/talkative-solutions-pvt.-ltd.?trk=top_nav_home"
        }
        
        UIApplication.shared.openURL(URL(string: bUrl)!)
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
