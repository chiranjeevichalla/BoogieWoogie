//
//  CalendarViewController.swift
//  Talkative Parents
//
//  Created by Basavaraj Kalaghatagi on 27/05/17.
//  Copyright © 2017 SGS. All rights reserved.
//

import UIKit
import ChameleonFramework
import FSCalendar
import Firebase
import DZNEmptyDataSet

class CalendarViewController: UIViewController {
    
    
    @IBOutlet weak var thisUICalendar: FSCalendar!

    @IBOutlet weak var thisUICalendarBaseView: UIView!
    
    
    @IBOutlet weak var thisUIEventsTableView: UITableView!
    
    var thisFIRDBRef : FIRDatabaseReference!
    
    var thisCalendarEvents : [CalendarEvent] = []
    
    var thisSelectedCalendarEvents : [CalendarEvent] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = Constants.sharedInstance._child.getName()
        // Do any additional setup after loading the view.
        self.setCalendarBaseColor()
        self.setUpEvents()
        getFirebaseCalendarEvents()
        
        self.thisUIEventsTableView.register(UINib(nibName: "CalendarEventTableViewCell", bundle: nil), forCellReuseIdentifier: "CalendarEventTableViewCell")
        self.thisUIEventsTableView.tableFooterView = UIView(frame: .zero)
        
        self.thisUIEventsTableView.emptyDataSetSource = self
        self.thisUIEventsTableView.emptyDataSetDelegate = self
        self.thisUIEventsTableView.reloadData()
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
    
    private func setCalendarBaseColor() {
        let firstColor = UIColor(red: 2/255, green: 150/255, blue: 154/255, alpha: 1.0)
        let secondColor = UIColor(red: 1/255, green: 66/255, blue: 68/255, alpha: 1.0)
        thisUICalendarBaseView.backgroundColor = UIColor(gradientStyle: UIGradientStyle.topToBottom, withFrame: (thisUICalendarBaseView.frame), andColors: [firstColor, secondColor])
        
        self.thisUICalendar.layer.cornerRadius = 5
    }
    
    private func setUpEvents() {
        
    }
    
    private func getFirebaseCalendarEvents() {
//        thisFIRDBRef = FireBaseHelper.SetCalendarFirebaseEventObserver(pSchoolId: Constants.sharedInstance._child.getSchoolId(), callback: { (bCalendarEvent, result) in
//            
//        }, callback1: {(pEvents, result)) in
//        }
        
        thisFIRDBRef = FireBaseHelper.SetCalendarFirebaseEventObserver(pSchoolId: Constants.sharedInstance._child.getSchoolId(), callback: { (pEvent, result) in
            if result {
                self.thisCalendarEvents.append(pEvent)
                self.thisUICalendar.reloadData()
            }
        }, callback1: { (pEvents, result) in
            self.thisUICalendar.reloadData()
        })
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
        if thisFIRDBRef != nil {
            thisFIRDBRef.removeAllObservers()
        }
    }

}
extension CalendarViewController: FSCalendarDelegate, FSCalendarDataSource {
    
    private func isDateExist(pDate: Date) -> Bool {
        var bExist = false
        for bCalendarEvent in self.thisCalendarEvents {
            if pDate >= bCalendarEvent.getStartDate() && pDate <= bCalendarEvent.getEndDate() {
                bExist = true
                break;
            }
        }
        return bExist
    }
    
    private func getCalendarEventsForSelectedDate(pDate : Date) -> [CalendarEvent] {
        var bCalendrEvents : [CalendarEvent] = []
        for bCalendarEvent in self.thisCalendarEvents {
            if pDate >= bCalendarEvent.getStartDate() && pDate <= bCalendarEvent.getEndDate() {
                bCalendrEvents.append(bCalendarEvent)
            }
        }
        return bCalendrEvents
    }
    
    func calendar(_ calendar: FSCalendar, hasEventFor date: Date) -> Bool {
        return isDateExist(pDate: date)
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("selected date \(date)")
        Commons.showIndicator()
        let bCalendarEvents = getCalendarEventsForSelectedDate(pDate: date)
        Commons.hideIndicator()
        self.thisSelectedCalendarEvents = bCalendarEvents
        self.thisUIEventsTableView.reloadData()
        
        print("calendar events count \(bCalendarEvents.count)")
    }
    
}

extension CalendarViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.thisSelectedCalendarEvents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CalendarEventTableViewCell = self.thisUIEventsTableView.dequeueReusableCell(withIdentifier: "CalendarEventTableViewCell", for: indexPath) as! CalendarEventTableViewCell
        
        cell.thisUITitleLabel.text = self.thisSelectedCalendarEvents[indexPath.row].getTitle()
        cell.thisUITimeLabel.text = self.thisSelectedCalendarEvents[indexPath.row].getDisplayDate()
        cell.thisUIPinButton.tag = indexPath.row
        cell.thisUIPinButton.addTarget(self, action: #selector(self.tapOnPinBtn), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let bVC = CalendarDetailViewController()
        bVC.thisCalendarEvent = self.thisSelectedCalendarEvents[indexPath.row]
        self.navigationController?.pushViewController(bVC, animated: true)
        
    }
    
    func tapOnPinBtn(sender: UIButton!) {
        print("pin or unpin the events")
    }
    
}

extension CalendarViewController : DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "No Data"
        
        
        let attrs = [NSFontAttributeName: UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "No Pinned Events for the selected date"
        
        let attrs = [NSFontAttributeName: UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    //    func buttonTitle(forEmptyDataSet scrollView: UIScrollView, for state: UIControlState) -> NSAttributedString? {
    //        var str = ""
    //
    //        return NSAttributedString(string: str, attributes : nil)
    //    }
    
    func emptyDataSet(_ scrollView: UIScrollView!, didTap view: UIView!) {
        
    }
    
    func emptyDataSet(_ scrollView: UIScrollView, didTap button: UIButton) {
        //        if self._historyType == 0 {
        //
        //        }
        
    }
    
    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
    
    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
    
}
