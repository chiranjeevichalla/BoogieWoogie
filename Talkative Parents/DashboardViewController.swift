//
//  DashboardViewController.swift
//  Talkative Parents
//
//  Created by Basavaraj Kalaghatagi on 18/05/17.
//  Copyright © 2017 SGS. All rights reserved.
//

import UIKit
import AnimatedCollectionViewLayout

class DashboardViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var thisUICollectionView: UICollectionView!
    
    
    private var isCVLoaded = false
    private var thisScreenWidth : CGFloat = 0.0
    
    var thisChildrens : [Child] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Talkative Parents"
        let myimage = UIImage(named: "refresh1")?.withRenderingMode(.alwaysOriginal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: myimage, style: .plain, target: self, action: #selector(ButtonTapped))

        thisScreenWidth = self.view.bounds.width
        thisUICollectionView.register(UINib(nibName: "DashboardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DashboardCollectionViewCell")
        // Do any additional setup after loading the view.
        getChildrenWithChannels()
    }
    
    func ButtonTapped() {
        print("Button Tapped")
        getChildrenWithChannels()
    }
    
    private func getChildrenWithChannels() {
        ChildrenService.GetChildrenWithChannels { (newChildrens, result) in
            print("found channels")
            if result {
                self.thisChildrens = newChildrens
                self.thisUICollectionView.reloadData()
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        if isCVLoaded {
           // return
        }
        isCVLoaded = true
        
        /*let layout = AnimatedCollectionViewLayout()
        layout.animator = SnapInAttributesAnimator()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: thisUICollectionView.bounds.width-10 , height: thisUICollectionView.bounds.height)
        let bTop = 63 * thisUICollectionView.bounds.height / 201
        
        layout.sectionInset = UIEdgeInsets(top: -bTop, left: 5, bottom: 0, right: 5)
        
        thisUICollectionView.collectionViewLayout = layout
 */
        
        if let layout = thisUICollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: thisUICollectionView.bounds.width-20 , height: thisUICollectionView.bounds.height)
            print(thisUICollectionView.bounds.height)
            thisScreenWidth = thisUICollectionView.bounds.width
            let bTop = 63 * thisUICollectionView.bounds.height / 201
            
            layout.sectionInset = UIEdgeInsets(top: -bTop, left: 5, bottom: 0, right: 5)
            layout.minimumLineSpacing = 10
            layout.invalidateLayout()
        }
        
        thisUICollectionView.reloadData()
        
    }
    
    // MARK: Collectionview Delegates & Data Sources
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return thisChildrens.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : DashboardCollectionViewCell = thisUICollectionView.dequeueReusableCell(withReuseIdentifier: "DashboardCollectionViewCell", for: indexPath) as! DashboardCollectionViewCell
        
        cell.layer.cornerRadius = 5
        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.borderWidth = 3
        
        cell.thisUIChildName.text = self.thisChildrens[indexPath.item].getName()+"("+self.thisChildrens[indexPath.item].getBatchName()+")"
        cell.thisUISchoolName.text = self.thisChildrens[indexPath.item].getSchoolName()
        Commons.setImage(pImage: cell.thisUISchoolImage, pUrl: self.thisChildrens[indexPath.item].getSchoolLogo())
        
        return cell
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / scrollView.frame.width)
        let path = NSIndexPath(item: index, section: 0)
        thisUICollectionView.scrollToItem(at: path as IndexPath, at: .centeredHorizontally, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        Constants.sharedInstance._child = self.thisChildrens[indexPath.item]
        
        let appDelegate = UIApplication.shared.delegate! as! AppDelegate
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "tabBarController1")
        appDelegate.window?.rootViewController = initialViewController
        appDelegate.window?.makeKeyAndVisible()
        
    }

    /*
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let bTop = 63 * thisUICollectionView.bounds.height / 201
        let edgeInsets = (thisScreenWidth - (CGFloat(5) * 50) - (CGFloat(5) * 10)) / 2
        return UIEdgeInsets(top: -bTop, left: edgeInsets, bottom: 0, right: 0)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let leftAndRightPaddings: CGFloat = 15.0
        let numberOfItemsPerRow: CGFloat = CGFloat(2)
        
        let bounds = UIScreen.main.bounds
        let width = (bounds.size.width - leftAndRightPaddings * (numberOfItemsPerRow+1)) / numberOfItemsPerRow
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: collectionView.bounds.height)
        
        return layout.itemSize
    }
     */
    
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
