//
//  CategorySelectionViewController.swift
//  Talkative Parents
//
//  Created by Basavaraj Kalaghatagi on 03/06/17.
//  Copyright © 2017 SGS. All rights reserved.
//

import UIKit
import Eureka

class CategorySelectionViewController: UIViewController, TypedRowControllerType, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var thisUITV: UITableView!
    
    var thisCategories: [Category] = []
    
    public var onDismissCallback: ((UIViewController) -> ())?
    public var row: RowOf<Category1>!
    private var thisSelectedKey : String = ""
    
    convenience public init(_ callback: ((UIViewController) -> ())?){
        self.init(nibName: nil, bundle: nil)
        onDismissCallback = callback
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.thisUITV.register(UINib(nibName: "CountrySelectionTableViewCell", bundle: nil), forCellReuseIdentifier: "CountrySelectionTableViewCell")
        self.thisUITV.tableFooterView = UIView(frame: .zero)
        // Do any additional setup after loading the view.
        if self.row.value != nil {
            let bKey = self.row.value?.getKey()
            thisSelectedKey = bKey!
        }
        getCategories()
    }
    
    private func getCategories() {
        FireBaseHelper.GetCategories(callback: { (_, _) in
            
        }) { (pCategories, result) in
            self.thisCategories = pCategories
            
            self.thisUITV.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return thisCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CountrySelectionTableViewCell = self.thisUITV.dequeueReusableCell(withIdentifier: "CountrySelectionTableViewCell", for: indexPath) as! CountrySelectionTableViewCell
        
        cell.thisUILabel.text = thisCategories[indexPath.row].getName()
//
        if self.thisSelectedKey == thisCategories[indexPath.row].getKey() {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
//
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //close
        let bCategory = Category1()
        bCategory._name = self.thisCategories[indexPath.row].getName()
        bCategory._status = self.thisCategories[indexPath.row]._status
        bCategory._key = self.thisCategories[indexPath.row].getKey()
        row.value = bCategory
        onDismissCallback?(self)
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
