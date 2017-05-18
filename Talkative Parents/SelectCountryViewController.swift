//
//  SelectCountryViewController.swift
//  Talkative Parents
//
//  Created by Basavaraj Kalaghatagi on 18/05/17.
//  Copyright © 2017 SGS. All rights reserved.
//

import UIKit



class SelectCountryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var thisUICountryTable: UITableView!
    
    var thisSelectedCountry : Country!
    var thisSelectedCountries : [Country]!
    
    var thisCountrySelectionDelegate : updateSelectedCountry?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: Bundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.thisUICountryTable.register(UINib(nibName: "CountrySelectionTableViewCell", bundle: nil), forCellReuseIdentifier: "CountrySelectionTableViewCell")
        self.thisUICountryTable.tableFooterView = UIView(frame: .zero)
        // Do any additional setup after loading the view.
    }
    
    // MARK: TableView delegates and datasources
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return thisSelectedCountries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CountrySelectionTableViewCell = self.thisUICountryTable.dequeueReusableCell(withIdentifier: "CountrySelectionTableViewCell", for: indexPath) as! CountrySelectionTableViewCell
        
        cell.thisUILabel.text = thisSelectedCountries[indexPath.row].getName()
        
        if thisSelectedCountry.getId() == thisSelectedCountries[indexPath.row].getId() {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //close
        if thisCountrySelectionDelegate != nil {
            thisCountrySelectionDelegate?.setSelectedCountry(pNewSelectedCountry: thisSelectedCountries[indexPath.item])
        }
        self.navigationController?.popViewController(animated: true)
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
