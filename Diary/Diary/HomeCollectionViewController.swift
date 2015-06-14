//
//  HomeCollectionViewController.swift
//  Diary
//
//  Created by wyatt on 15/6/13.
//  Copyright (c) 2015年 Wanqing Wang. All rights reserved.
//

import UIKit
import CoreData

let itemHeight: CGFloat = 150.0 // Cell 的高度
let itemWidth: CGFloat = 60     // Cell 的宽度
let collectionViewWidth = itemWidth * 3 // 同时显示三个Cell的时候



class HomeCollectionViewController: UICollectionViewController {
    
    var diarys = [NSManagedObject]()
    var fetchedResultsController: NSFetchedResultsController!
    var yearsCount: Int = 1
    var sectionsCount: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        var yearLayout = DiaryLayout()
//        yearLayout.scrollDirection = UICollectionViewScrollDirection.Horizontal
//        self.collectionView?.setCollectionViewLayout(yearLayout, animated: false)
//        
//        self.collectionView?.frame = CGRectMake(0, 0, collectionViewWidth, itemHeight)
//        self.collectionView?.center = CGPoint(x: view.frame.size.width/2.0, y: view.frame.size.height/2.0)
//        
//        self.view.backgroundColor = UIColor.whiteColor()
//        
//        self.navigationController?.delegate = self
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 加截数据
    func loadData() {
        let fetchRequest = NSFetchRequest(entityName: "Diary")
        let entity = NSEntityDescription.entityForName("Diary", inManagedObjectContext: managedContext)
        var error: NSError?
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "created_at", ascending: true)]
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedContext, sectionNameKeyPath: "year", cacheName: nil)
        if !fetchedResultsController.performFetch(&error) {
            println("Error: \(error?.localizedDescription)")
        } else {
            var fetchedResults = fetchedResultsController.fetchedObjects as! [NSManagedObject]
            if fetchedResults.count == 0 {
                println("Present empty year")
            } else {
                if let sectionsCount = fetchedResultsController.sections?.count {
                    yearsCount = sectionsCount
                    diarys = fetchedResults
                } else {
                    sectionsCount = 0
                    yearsCount = 1
                }
            }
        }
        
        var yearLayout = DiaryLayout()
        yearLayout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        self.collectionView?.setCollectionViewLayout(yearLayout, animated: false)
        self.collectionView?.frame = CGRect(x: 0, y: 0, width: collectionViewWidth, height: itemHeight)
        self.collectionView?.center = CGPoint(x: self.view.frame.size.width/2.0, y: self.view.frame.size.height/2.0)
        
        self.view.backgroundColor = UIColor.whiteColor()
        self.navigationController?.delegate = self
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return yearsCount
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(CollectionCellIdetifiers.homeYearCellIdentifiers, forIndexPath: indexPath) as! HomeYearCollectionViewCell
        var components = NSCalendar.currentCalendar().component(NSCalendarUnit.CalendarUnitYear, fromDate: NSDate())
        var year = components
        if sectionsCount > 0 {
            if let sectionInfo = fetchedResultsController.sections![indexPath.row] as? NSFetchedResultsSectionInfo {
                println("Section info \(sectionInfo.name)")
                year = sectionInfo.name!.toInt()!
            }
        }
        cell.textInt = year
        cell.labelText = "\(numberToChinese(cell.textInt)) 年"
    
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        var leftRightMagrin = (collectionViewWidth - itemWidth)/2
        return UIEdgeInsetsMake(0, leftRightMagrin, 0, leftRightMagrin);
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // 直接回载storyboard
        var dvc = self.storyboard?.instantiateViewControllerWithIdentifier(StoryboardIdentifiers.diaryYearIdentifiers) as! DiaryYearCollectionViewController
        
        var components = NSCalendar.currentCalendar().component(NSCalendarUnit.CalendarUnitYear, fromDate: NSDate())
        var year = components
        if sectionsCount > 0 {
            if let sectionInfo = fetchedResultsController.sections![indexPath.row] as? NSFetchedResultsSectionInfo {
                println("Section info \(sectionInfo.name)")
                year = sectionInfo.name!.toInt()!
            }
        }
        
        dvc.year = year
        self.navigationController?.pushViewController(dvc, animated: true)
        
    }

}

extension HomeCollectionViewController: UINavigationControllerDelegate {
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        var animator = DiaryAnimator()
        animator.operation = operation
        return animator
    }
}
