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


class CalendarViewController: UIViewController {
    
    
    @IBOutlet weak var thisUICalendar: FSCalendar!

    @IBOutlet weak var thisUICalendarBaseView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setCalendarBaseColor()
        self.setUpEvents()
    }
    
    private func setCalendarBaseColor() {
        let firstColor = UIColor(red: 2/255, green: 150/255, blue: 154/255, alpha: 1.0)
        let secondColor = UIColor(red: 1/255, green: 66/255, blue: 68/255, alpha: 1.0)
        thisUICalendarBaseView.backgroundColor = UIColor(gradientStyle: UIGradientStyle.topToBottom, withFrame: (thisUICalendarBaseView.frame), andColors: [firstColor, secondColor])
    }
    
    private func setUpEvents() {
        
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
extension CalendarViewController: FSCalendarDelegate, FSCalendarDataSource {
    
    func calendar(_ calendar: FSCalendar, hasEventFor date: Date) -> Bool {
        return true
    }
    
}
