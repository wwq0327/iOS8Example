//
//  DiaryViewController.swift
//  Diary
//
//  Created by wyatt on 15/6/14.
//  Copyright (c) 2015年 Wanqing Wang. All rights reserved.
//

import UIKit

class DiaryViewController: UIViewController, UIWebViewDelegate, UIScrollViewDelegate, UIGestureRecognizerDelegate {
    
    var diary: Diary!
    var webView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        setupUI()
    }
    
    func setupUI() {
        webView = UIWebView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height))
        webView.scrollView.bounces = true
        webView.delegate = self
        webView.backgroundColor = UIColor.whiteColor()
        
        self.view.addSubview(webView)
        
        // 添加手势
        var mDoubleUpRecognizer = UITapGestureRecognizer(target: self, action: "hideDiary")
        mDoubleUpRecognizer.delegate = self
        mDoubleUpRecognizer.numberOfTapsRequired = 2
        self.webView.addGestureRecognizer(mDoubleUpRecognizer)
        
        var mTapUpRecognizer = UITapGestureRecognizer(target: self, action: "showButtons")
        mTapUpRecognizer.delegate = self
        mTapUpRecognizer.numberOfTapsRequired = 1
        self.webView.addGestureRecognizer(mTapUpRecognizer)
        mTapUpRecognizer.requireGestureRecognizerToFail(mDoubleUpRecognizer)
        
        webView.alpha = 0.0
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reloadWebView:", name: "DiaryChangeFont", object: nil)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        reloadWebView()
    }

    func reloadWebView() {
        var timeString = "\(numberToChinese(NSCalendar.currentCalendar().component(NSCalendarUnit.CalendarUnitYear, fromDate: diary.created_at)))年 \(numberToChineseWithUnit(NSCalendar.currentCalendar().component(NSCalendarUnit.CalendarUnitMonth, fromDate: diary.created_at)))月 \(numberToChineseWithUnit(NSCalendar.currentCalendar().component(NSCalendarUnit.CalendarUnitDay, fromDate: diary.created_at)))日"
        
        var newDiaryString = diary.content.stringByReplacingOccurrencesOfString("\n", withString: "<br>", options: NSStringCompareOptions.LiteralSearch, range: nil)
        
        var title = ""
        var contentWidthOffset = 140
        var contentMargin:CGFloat = 10
        
        if let titleStr = diary?.title {
            var parsedTime = "\(numberToChineseWithUnit(NSCalendar.currentCalendar().component(NSCalendarUnit.CalendarUnitDay, fromDate: diary.created_at))) 日"
            if titleStr != parsedTime {
                title = titleStr
                contentWidthOffset = 205
                contentMargin = 10
                title = "<div class='title'>\(title)</div>"
            }
        }
        
        var minWidth = self.view.frame.size.width - CGFloat(contentWidthOffset)
        
        var fontStr = defaultFont
        
        var bodyPadding = 0
        
        var containerCSS = " padding:25px 10px 25px 25px; "
        
        
        var titleMarginRight:CGFloat = 15
        
        
        let headertags = "<!DOCTYPE html><html><meta charset='utf-8'><head><title></title><style>"
        let bodyCSS = "body{padding:\(bodyPadding)px;} "
        let allCSS = "* {-webkit-text-size-adjust: 100%; margin:0; font-family: '\(fontStr)'; -webkit-writing-mode: vertical-rl; letter-spacing: 3px;}"
        let contentCSS = ".content { min-width: \(minWidth)px; margin-right: \(contentMargin)px;} .content p{ font-size: 12pt; line-height: 24pt;}"
        let titleCSS = ".title {font-size: 12pt; font-weight:bold; line-height: 24pt; margin-right: \(titleMarginRight)px; padding-left: 20px;} "
        let extraCSS = ".extra{ font-size:12pt; line-height: 24pt; margin-right:30px; }"
        let stampCSS = ".stamp {width:24px; height:auto; position:fixed; bottom:20px;}"
        
        
        let extraHTML = "<div class='extra'>于 \(diary.location!)<br>\(timeString) </div>"
        let contentHTML = "<div class='container'>\(title)<div class='content'><p>\(newDiaryString)</p></div>"
        
        webView.loadHTMLString("\(headertags)\(bodyCSS) \(allCSS) \(contentCSS) \(titleCSS) \(extraCSS) .container { \(containerCSS) } \(stampCSS) </style></head> <body> \(contentHTML) \(extraHTML)</body></html>", baseURL: nil)
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        UIView.animateWithDuration(1.0, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.webView.alpha = 1.0
        }, completion: nil)
        webView.scrollView.contentOffset = CGPointMake(webView.scrollView.contentSize.width - webView.frame.size.width, 0)
    }
    
    func hideDiary() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func showButtons() {
        
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailByGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y < -80 {
            hideDiary()
        }
    }

}
