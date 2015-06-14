//
//  DiaryMonthDayCollectionViewController.swift
//  Diary
//
//  Created by wyatt on 15/6/14.
//  Copyright (c) 2015年 Wanqing Wang. All rights reserved.
//

import UIKit

class DiaryMonthDayCollectionViewController: UICollectionViewController {
    
    var month: Int!
    var year: Int!
    var yearLabel: UILabel!
    var composeButton: UIButton!
    var monthLabel: DiaryLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 年份标签
        yearLabel = DiaryLabel(fontname: "TpldKhangXiDictTrial", labelText: "\(numberToChinese(year))年", fontSize: 20.0, lineHeight: 5.0)
        yearLabel.center = CGPointMake(screenRect.width - yearLabel.frame.size.width/2.0-15, 20+yearLabel.frame.size.height/2.0)
        self.view.addSubview(yearLabel)
        yearLabel.userInteractionEnabled = true
        
        // 手势
        var mTapUpRecognizer = UITapGestureRecognizer(target: self, action: "backToHome")
        mTapUpRecognizer.numberOfTapsRequired = 1
        yearLabel.addGestureRecognizer(mTapUpRecognizer)
        
        //Add compose button
        
        composeButton = diaryButtonWith(text: "撰",  fontSize: 14.0,  width: 40.0,  normalImageName: "Oval", highlightedImageName: "Oval_pressed")
        
        composeButton.center = CGPointMake(screenRect.width - yearLabel.frame.size.width/2.0 - 15, 38 + yearLabel.frame.size.height + 26.0/2.0)
        
        composeButton.addTarget(self, action: "newCompose", forControlEvents: UIControlEvents.TouchUpInside)
        
        
        self.view.addSubview(composeButton)
        
        monthLabel = DiaryLabel(fontname: "Wyue-GutiFangsong-NC", labelText: "\(numberToChineseWithUnit(month)) 月", fontSize: 16.0,lineHeight: 5.0)
        monthLabel.frame = CGRectMake(screenRect.width - 15.0 - monthLabel.frame.size.width, (screenRect.height - 150)/2.0, monthLabel.frame.size.width, monthLabel.frame.size.height)
        
        monthLabel.center = CGPointMake(composeButton.center.x, monthLabel.center.y + 28)
        
        monthLabel.updateLabelColor(DiaryRed)
        monthLabel.userInteractionEnabled = true
        
        var mmTapUpRecognizer = UITapGestureRecognizer(target: self, action: "backToYear:")
        mmTapUpRecognizer.numberOfTapsRequired = 1
        monthLabel.addGestureRecognizer(mmTapUpRecognizer)
        
        
        self.view.addSubview(monthLabel)
        
        
        var yearLayout = DiaryLayout()
        
        yearLayout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        self.collectionView?.setCollectionViewLayout(yearLayout, animated: false)
        
        self.collectionView!.frame = CGRect(x:0, y:0, width: collectionViewWidth, height: itemHeight)
        self.collectionView!.center = CGPoint(x: self.view.frame.size.width/2.0, y: self.view.frame.size.height/2.0)
        
        self.view.backgroundColor = UIColor.whiteColor()
    }
    
    func newCompose() {
        let composeViewController = self.storyboard?.instantiateViewControllerWithIdentifier(StoryboardIdentifiers.diaryComposeViewController) as! DiaryComposeViewController
        self.presentViewController(composeViewController, animated: true, completion: nil)
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(CollectionCellIdetifiers.diaryCellIdentifiers, forIndexPath: indexPath) as! DiaryCollectionViewCell
        cell.labelText = "一十四日"
        cell.textInt = 6
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        var leftRightMagrin = (collectionViewWidth - itemWidth)/2
        return UIEdgeInsetsMake(0, leftRightMagrin, 0, leftRightMagrin);
    }
    
}
