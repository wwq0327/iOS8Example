//
//  ViewController.swift
//  TextViewKeyboardDemo
//
//  Created by wyatt on 15/5/1.
//  Copyright (c) 2015年 Wanqing Wang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var textView: UITextView!
    var originalTextViewFrame: CGRect!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // 注册消息
        let defaultCenter = NSNotificationCenter.defaultCenter()
        
        // 打开键盘
        defaultCenter.addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        // 关闭键盘
        defaultCenter.addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func keyboardWillShow(notification: NSNotification)
    {
        moveTextviewForKeyboard(notification, up: true)
    }
    
    func keyboardWillHide(notification: NSNotification) {
        moveTextviewForKeyboard(notification, up: false)
    }
    
    
    func moveTextviewForKeyboard(notification: NSNotification, up: Bool) {
        
        let userInfo = notification.userInfo
        
        if let info = userInfo {
            // 动画持续时间
            let animationDurationObject = info[UIKeyboardAnimationDurationUserInfoKey] as! NSValue
            
            // 键盘尺寸
            let keyboardEndRectObject = info[UIKeyboardFrameEndUserInfoKey] as! NSValue
            
            var animationDuration = 0.0
            var keyboardEndRect = CGRectZero
            
            // 取出键值，分别给animationDuration,keyboardEndRect
            animationDurationObject.getValue(&animationDuration)
            keyboardEndRectObject.getValue(&keyboardEndRect)
            
            let window = UIApplication.sharedApplication().keyWindow
            keyboardEndRect = view.convertRect(keyboardEndRect, fromView: window)

            if up {
                UIView.animateWithDuration(animationDuration, animations: { [weak self] in
                    var keyboardTop = keyboardEndRect.origin.y
                    var newTextViewFrame = self?.textView.frame
                    self!.originalTextViewFrame = self!.textView.frame
                    newTextViewFrame?.size.height = keyboardTop - self!.textView.frame.origin.y - 20.0
                    self!.textView.frame = newTextViewFrame!
                    })
            } else {
                UIView.animateWithDuration(animationDuration, animations: {
                    [weak self] in
                    self!.textView.frame = self!.originalTextViewFrame!
                    })
            }
            
            UIView.commitAnimations()
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

