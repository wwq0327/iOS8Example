//
//  DiaryYearCollectionViewController.swift
//  Diary
//
//  Created by wyatt on 15/6/14.
//  Copyright (c) 2015年 Wanqing Wang. All rights reserved.
//

import UIKit



class DiaryYearCollectionViewController: UICollectionViewController {
    
    var year: Int!
    var yearLabel: UILabel!
    var composeButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        yearLabel = DiaryLabel(fontname: "TpldKhangXiDictTrial", labelText: "\(numberToChinese(year))年", fontSize: 20.0, lineHeight: 5.0)
        yearLabel.center = CGPointMake(screenRect.width-yearLabel.frame.size.width/2.0-15, 20+yearLabel.frame.size.height/2.0)
        self.view.addSubview(yearLabel)
        yearLabel.userInteractionEnabled = true
        
        var mTapUpRecognizer = UITapGestureRecognizer(target: self, action: "backToHome")
        mTapUpRecognizer.numberOfTapsRequired = 1
        yearLabel.addGestureRecognizer(mTapUpRecognizer)
        
        var composeButton = diaryButtonWith(text: "撰", fontSize: 14.0, width: 40.0, normalImageName: "Oval", highlightedImageName: "Oval_pressed")
        composeButton.center = CGPointMake(yearLabel.center.x, 38 + yearLabel.frame.size.height + 26.0/2.0)
        composeButton.addTarget(self, action: "newCompose", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(composeButton)
        
        var yearLayout = DiaryLayout()
        
        yearLayout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        self.collectionView?.setCollectionViewLayout(yearLayout, animated: false)
        
        self.collectionView?.frame = CGRect(x: 0, y: 0, width: collectionViewWidth, height: itemHeight)
        self.collectionView?.center = CGPoint(x: self.view.frame.size.width/2.0, y: self.view.frame.size.height/2.0)
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
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(CollectionCellIdetifiers.diaryCellIdentifiers, forIndexPath: indexPath) as! DiaryCollectionViewCell
        cell.labelText = "六月"
        cell.textInt = 6
        
        return cell
    }

    // 加载场景
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(CollectionCellIdetifiers.diaryCellIdentifiers, forIndexPath: indexPath) as! DiaryCollectionViewCell
        var dvc = self.storyboard?.instantiateViewControllerWithIdentifier(StoryboardIdentifiers.diaryMonthIdentifiers) as! DiaryMonthDayCollectionViewController
        dvc.year = 2015
        dvc.month = 6
        self.navigationController?.pushViewController(dvc, animated: true)
    }
    
    // 文字居中
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        var leftRightMagrin = (collectionViewWidth - itemWidth)/2
        return UIEdgeInsetsMake(0, leftRightMagrin, 0, leftRightMagrin);
    }

}
