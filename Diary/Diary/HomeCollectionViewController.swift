//
//  HomeCollectionViewController.swift
//  Diary
//
//  Created by wyatt on 15/6/13.
//  Copyright (c) 2015年 Wanqing Wang. All rights reserved.
//

import UIKit

let itemHeight: CGFloat = 150.0 // Cell 的高度
let itemWidth: CGFloat = 60     // Cell 的宽度
let collectionViewWidth = itemWidth * 3 // 同时显示三个Cell的时候

let reuseIdentifier = "Cell"

class HomeCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var yearLayout = DiaryLayout()
        yearLayout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        self.collectionView?.setCollectionViewLayout(yearLayout, animated: false)
        
        self.collectionView?.frame = CGRectMake(0, 0, collectionViewWidth, itemHeight)
        self.collectionView?.center = CGPoint(x: view.frame.size.width/2.0, y: view.frame.size.height/2.0)
        
        self.view.backgroundColor = UIColor.whiteColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return 1
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! HomeYearCollectionViewCell
        
        cell.textInt = 2015
        cell.labelText = "二零一五年"
    
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        var leftRightMagrin = (collectionViewWidth - itemWidth)/2
        return UIEdgeInsetsMake(0, leftRightMagrin, 0, leftRightMagrin);
    }
    

}
