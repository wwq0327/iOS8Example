//
//  DiaryYearCollectionViewController.swift
//  Diary
//
//  Created by wyatt on 15/6/14.
//  Copyright (c) 2015年 Wanqing Wang. All rights reserved.
//

import UIKit
import CoreData


class DiaryYearCollectionViewController: UICollectionViewController {
    
    var year: Int!
    var yearLabel: UILabel!
    var composeButton: UIButton!
    
    // data
    var diarys = [NSManagedObject]()
    var fetchedResultsController: NSFetchedResultsController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        
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
    
    func loadData() {
        let fetchRequest = NSFetchRequest(entityName: "Diary")
        var error: NSError?
        var year = 2015
        var month = 6
        
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as! [NSManagedObject]?
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "created_at", ascending: true)] // 排序方式
        fetchRequest.predicate = NSPredicate(format: "year = \(year) AND month = \(month)")
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedContext, sectionNameKeyPath: "month", cacheName: nil)
        if !fetchedResultsController.performFetch(&error) {
            println("Present empty year")
        } else {
            diarys = fetchedResults!
        }
    }

    
    func newCompose() {
        let composeViewController = self.storyboard?.instantiateViewControllerWithIdentifier(StoryboardIdentifiers.diaryComposeViewController) as! DiaryComposeViewController
        self.presentViewController(composeViewController, animated: true, completion: nil)
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
        if fetchedResultsController.sections?.count == 0 {
            cell.labelText = "\(numberToChineseWithUnit(NSCalendar.currentCalendar().component(NSCalendarUnit.CalendarUnitMonth, fromDate: NSDate()))) 月"
        } else {
            let sectionInfo = fetchedResultsController.sections![indexPath.row] as! NSFetchedResultsSectionInfo
            var month = sectionInfo.name?.toInt()
            cell.labelText = "\(numberToChineseWithUnit(month!)) 月"
        }
        
        return cell
    }

    // 加载场景
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(CollectionCellIdetifiers.diaryCellIdentifiers, forIndexPath: indexPath) as! DiaryCollectionViewCell
        var dvc = self.storyboard?.instantiateViewControllerWithIdentifier(StoryboardIdentifiers.diaryMonthIdentifiers) as! DiaryMonthDayCollectionViewController
        
        if fetchedResultsController.sections?.count == 0 {
            dvc.month = NSCalendar.currentCalendar().component(NSCalendarUnit.CalendarUnitMonth, fromDate: NSDate())
        }else{
            let sectionInfo = fetchedResultsController.sections![indexPath.row] as! NSFetchedResultsSectionInfo
            var month = sectionInfo.name?.toInt()
            dvc.month = month!
        }
        
        dvc.year = year
        
        self.navigationController?.pushViewController(dvc, animated: true)
    }
    
    // 文字居中
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        var leftRightMagrin = (collectionViewWidth - itemWidth)/2
        return UIEdgeInsetsMake(0, leftRightMagrin, 0, leftRightMagrin);
    }

}
