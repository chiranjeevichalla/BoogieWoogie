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
        self.navigationItem.title = Constants.sharedInstance._child.getName()
        self.thisUISBTV.emptyDataSetSource = self
        self.thisUISBTV.emptyDataSetDelegate = self
        // Do any additional setup after loading the view, typically from a nib.
        setUpTableView()
        
        let btn1 = UIButton(type: .custom)
        btn1.setImage(UIImage(named: "addSoundingBoard"), for: .normal)
        btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn1.addTarget(self, action: #selector(self.addSoundingBoardMessage), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: btn1)
        self.navigationItem.setRightBarButtonItems([item1], animated: true)
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
    
    func addSoundingBoardMessage() {
        print("add new sounding board message")
        createNewMessage()
    }

    private func setSoundingFireBase() {
        
        FireBaseHelper.GetSoundingBoard(pType: "private", callback: { (pSoundingBoard, result) in
            if result {
                self.thisMessages.append(pSoundingBoard)
                self.thisUISBTV.reloadData()
            }
        }, callback1: { (_, _) in
            
        }) { (pSoundingBoard, result) in
            if result {
                //check psoundingboard key with other
                var bRow = 0
                for row in self.thisMessages {
                    if row.getFirebaseKey() == pSoundingBoard.getFirebaseKey() {
                        self.thisMessages[bRow] = pSoundingBoard
                        let indexPath = IndexPath(item: bRow, section: 0)
                        self.thisUISBTV.reloadRows(at: [indexPath], with: .fade)
//                        self.thisUISBTV.scrollToRow(at: indexPath, at: .bottom, animated: true)
                        break;
                    }
                    bRow = bRow + 1
                }
                // if exist replace with this soundingboard and reload the row
            }
        }

    }
    
    private func setUpTableView() {
        self.thisUISBTV.register(UINib(nibName: "SoundingBoardTableViewCell", bundle: nil), forCellReuseIdentifier: "SoundingBoardTableViewCell")
        
        self.thisUISBTV.tableFooterView = UIView(frame: .zero)
        
        setSoundingFireBase()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.thisMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : SoundingBoardTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SoundingBoardTableViewCell", for: indexPath) as! SoundingBoardTableViewCell
        let bMessage =  self.thisMessages[indexPath.row]
        cell.thisUISubjectLabel.text = bMessage.getSubject()
        
        if bMessage.getCommentsCount() == 0 {
            cell.thisUICommentsLabel.text = "No comments "
        } else {
            cell.thisUICommentsLabel.text = "\(bMessage.getCommentsCount()) comments "
        }
        
        if bMessage.getAttachmentCount() == 0 {
            cell.thisUIAttachmentLabel.text = "No Attachments"
        } else {
            cell.thisUIAttachmentLabel.text = "\(bMessage.getAttachmentCount()) Attachments"
        }
        
        cell.thisUISubTitleLabel.text = "\(bMessage.getCategoryName()) - \(bMessage.getDate())"
        
        cell.thisUIDescriptionLabel.text = bMessage.getDescription()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let bVC = SoundingBoardDetailViewController()
        bVC.thisSoundingBoard = self.thisMessages[indexPath.row]
        self.present(bVC, animated: true, completion: nil)
    }
    
    private func createNewMessage() {
        let bVC = CreateSoundingBoardMessageViewController()
        self.navigationController?.pushViewController(bVC, animated: true)
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

