//
//  SecondViewController.swift
//  Talkative Parents
//
//  Created by Basavaraj Kalaghatagi on 15/05/17.
//  Copyright © 2017 SGS. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class SoundingboardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var thisUISBTV: UITableView!
    
    var thisMessages : [SoundingBoard] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.thisUISBTV.emptyDataSetSource = self
        self.thisUISBTV.emptyDataSetDelegate = self
        // Do any additional setup after loading the view, typically from a nib.
//        setUpTableView()
        
        let btn1 = UIButton(type: .custom)
        btn1.setImage(UIImage(named: "addSoundingBoard"), for: .normal)
        btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn1.addTarget(self, action: #selector(self.addSoundingBoardMessage), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: btn1)
        self.navigationItem.setRightBarButtonItems([item1], animated: true)
    }
    
    func addSoundingBoardMessage() {
        print("add new sounding board message")
    }

    
    private func setUpTableView() {
        self.thisUISBTV.register(UINib(nibName: "SoundingBoardTableViewCell", bundle: nil), forCellReuseIdentifier: "SoundingBoardTableViewCell")
        
        self.thisUISBTV.tableFooterView = UIView(frame: .zero)
        
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.thisMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : SoundingBoardTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SoundingBoardTableViewCell", for: indexPath) as! SoundingBoardTableViewCell
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension SoundingboardViewController : DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "No Messages Found"
        
        let attrs = [NSFontAttributeName: UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "Not initiated any messages, Tap + button on top Right to initiate"
        
        let attrs = [NSFontAttributeName: UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    
    
    func emptyDataSet(_ scrollView: UIScrollView!, didTap view: UIView!) {
        
    }
    
    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
    
    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
        return false
    }
    
}

