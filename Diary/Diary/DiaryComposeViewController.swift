//
//  DiaryComposeViewController.swift
//  Diary
//
//  Created by wyatt on 15/6/14.
//  Copyright (c) 2015年 Wanqing Wang. All rights reserved.
//

import UIKit
import CoreData

let titleTextViewHeight: CGFloat = 30.0
let contentMargin: CGFloat = 20.0

class DiaryComposeViewController: UIViewController {
    
    var composeView: UITextView!
    var localtionTextView: UITextView!
    var titleTextView: UITextView!
    
    var keyboardSize: CGSize = CGSizeMake(0, 0)
    var finishButton: UIButton!
    var diary: Diary?
    
    var localtionHelper: DiaryLocationHelper = DiaryLocationHelper()
    var changeText = false
    var changeTextCount = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ?????????????
        let containerSize = CGSize(width: screenRect.width, height: CGFloat.max)
        let container = NSTextContainer(size: containerSize)
        container.widthTracksTextView = true
        let layoutManager = NSLayoutManager()
        
        // textView 属性设置
        composeView = UITextView(frame: CGRectMake(0, contentMargin+titleTextViewHeight, screenRect.width, screenRect.height))
        composeView.font = DiaryFont
        composeView.editable = true
        composeView.userInteractionEnabled = true
        composeView.textContainerInset = UIEdgeInsetsMake(contentMargin, contentMargin, contentMargin, contentMargin)
        
        // add locationtextView
        localtionTextView = UITextView(frame: CGRectMake(0, composeView.frame.size.height - 30.0, screenRect.width - 60.0, 30.0))
        localtionTextView.font = DiaryLocationFont
        localtionTextView.editable = true
        localtionTextView.userInteractionEnabled = true
        localtionTextView.alpha = 0.0
        localtionTextView.bounces = false
        
        // add titleview
        titleTextView = UITextView(frame: CGRectMake(contentMargin, contentMargin/2, screenRect.width-60.0, titleTextViewHeight))
        titleTextView.font = DiaryTitleFont
        titleTextView.editable = true
        titleTextView.userInteractionEnabled = true
        titleTextView.bounces = false
        
        if let diary = diary {
            composeView.text = diary.content
            self.composeView.contentOffset = CGPointMake(0, self.composeView.contentSize.height)
            localtionTextView.text = diary.location
            localtionTextView.alpha = 1.0
            if let title = diary.title {
                titleTextView.text = title
            } else {
                titleTextView.text = "\(numberToChineseWithUnit(NSCalendar.currentCalendar().component(NSCalendarUnit.CalendarUnitDay, fromDate: diary.created_at))) 日"
            }
        } else {
            var date = NSDate()
            titleTextView.text = "\(numberToChineseWithUnit(NSCalendar.currentCalendar().component(NSCalendarUnit.CalendarUnitDay, fromDate: date))) 日"
        }
        
        composeView.becomeFirstResponder()
        self.view.addSubview(composeView)
        self.view.addSubview(localtionTextView)
        self.view.addSubview(titleTextView)
        
        // Add finish button
        finishButton = diaryButtonWith(text: "完", fontSize: 18.0, width: 50.0, normalImageName: "Oval", highlightedImageName: "Oval_pressed")
        finishButton.center = CGPointMake(screenRect.width - 20, screenRect.height - 30)
        finishButton.addTarget(self, action: "finishCompose:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(finishButton)
        
        self.finishButton.center = CGPointMake(self.view.frame.width - self.finishButton.frame.size.height/2.0-10, self.view.frame.height - self.finishButton.frame.height/2.0-10)
        self.localtionTextView.center = CGPointMake(self.localtionTextView.frame.size.height/2.0+20.0, self.finishButton.center.y)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidShow:", name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidShow:", name: UIKeyboardWillChangeFrameNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidHide:", name: UIKeyboardDidHideNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateAddress:", name: "DiaryLocationUpdated", object: nil)
    }
    
    func updateAddress(notification: NSNotification) {
        if let address = notification.object as? String {
            println("Author at \(address)")
            if let lastLocation = diary?.location {
                localtionTextView.text = diary?.location
            } else {
                localtionTextView.text = "于 \(address)"
            }
            
            UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                self.localtionTextView.alpha = 1.0
                }, completion: nil)
            localtionHelper.locationManager.stopUpdatingLocation()
        }
    }
    
    // 完成，保存数据到coredata
    func finishCompose(button: UIButton) {
        println("Finish compose")
        self.composeView.endEditing(true)
        self.localtionTextView.endEditing(true)
        
        if (composeView.text.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 1) {
            if let diary = diary {
                diary.content = composeView.text
                diary.location = localtionTextView.text
                diary.title = titleTextView.text
            } else {
                let entry = NSEntityDescription.entityForName("Diary", inManagedObjectContext: managedContext)
                let newdiary = Diary(entity: entry!, insertIntoManagedObjectContext: managedContext)
                newdiary.content = composeView.text
                
                if let address = localtionHelper.address {
                    newdiary.location = address
                }
                
                if let title = titleTextView.text {
                    newdiary.title = title
                }
                
                newdiary.updateTimeWithDate(NSDate())
                
            }
            var error: NSError?
            if !managedContext.save(&error) {
                println("Could not save \(error), \(error?.userInfo)")
            }
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func updateTextViewSizeForKeyboardHeight(keyboardHeight: CGFloat) {
        var newKeyboardHeight = keyboardHeight
        UIView.animateWithDuration(1.0, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            if (self.localtionTextView.text == nil) {
                self.composeView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - newKeyboardHeight)
            } else {
                self.composeView.frame = CGRectMake(0, contentMargin + titleTextViewHeight, self.composeView.frame.size.width, self.view.frame.height - newKeyboardHeight - 40.0 - self.finishButton.frame.size.height/2.0-(contentMargin+titleTextViewHeight))
            }
            self.finishButton.center = CGPointMake(self.view.frame.width - self.finishButton.frame.size.height/2.0 - 10, self.view.frame.height - newKeyboardHeight-self.finishButton.frame.size.width/2.0-10)
            self.localtionTextView.center = CGPointMake(self.localtionTextView.frame.size.width/2.0 + 20, self.finishButton.center.y)
        }, completion: nil)
    }
    
    func keyboardDidShow(notification: NSNotification) {
        if let rectValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            keyboardSize = rectValue.CGRectValue().size
            updateTextViewSizeForKeyboardHeight(keyboardSize.height)
        }
    }
    
    func keyboardDidHide(notification: NSNotification) {
        updateTextViewSizeForKeyboardHeight(0)
    }


}
