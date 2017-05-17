//
//  HelpScreenViewController.swift
//  Talkative Parents
//
//  Created by Basavaraj Kalaghatagi on 16/05/17.
//  Copyright © 2017 SGS. All rights reserved.
//

import UIKit


class HelpScreenViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var thisUICollectionView: UICollectionView!
    
    @IBOutlet weak var thisUIPageControl: CustomImagePageControl!
    private var thisCollectionViewCellSize = CGSize(width: 100, height: 100)
    
    
    private var isCVLoaded = false

    override func viewDidLoad() {
        super.viewDidLoad()

//        thisUICollectionView.reloadData()
        thisUIPageControl.currentPage = 0
//        thisUIPageControl.transform = CGAffineTransform(scaleX: 1.3, y: 1)
        thisUIPageControl.setUp()
//        thisUIPageControl.updateDots()
        // Do any additional setup after loading the view.
//        
//        let cellSize = CGSize(width:self.view.frame.width , height:self.view.frame.height)
//        
//        let layout =  UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        layout.itemSize = cellSize
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        layout.minimumLineSpacing = 0.0
//        layout.minimumInteritemSpacing = 0.0
//        thisUICollectionView.setCollectionViewLayout(layout, animated: true)
//        thisCollectionViewCellSize.width = self.view.frame.width
//        thisCollectionViewCellSize.height = self.view.frame.height
        thisUICollectionView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        if isCVLoaded {
            return
        }
        isCVLoaded = true
        
        if let layout = thisUICollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: thisUICollectionView.bounds.width , height: thisUICollectionView.bounds.height)
            layout.invalidateLayout()
        }
        thisUICollectionView.reloadData()
        
        thisUIPageControl.currentPage = 0
        thisUIPageControl.setUp()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return getHelpCell(indexPath: indexPath)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        
//        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
//    }
    
    
    private func getHelpCell(indexPath: IndexPath) -> UICollectionViewCell {
        let cell : HelpScreenCollectionViewCell = self.thisUICollectionView.dequeueReusableCell(withReuseIdentifier: "helpScreenUiCollectionViewCell", for: indexPath) as! HelpScreenCollectionViewCell
        cell.thisUIBg.image = UIImage(named : "helpBg\(indexPath.item+1)")
        
        return cell
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / scrollView.frame.width)
        thisUIPageControl.currentPage = index
        thisUIPageControl.updateDots()
        print("scrollviewdidscroll \(index)")
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
