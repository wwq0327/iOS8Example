//
//  ViewController.swift
//  KeyDemo
//
//  Created by wyatt on 15/4/30.
//  Copyright (c) 2015年 Wanqing Wang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    // 加载视图
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // 视图呈现后调用
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let center = NSNotificationCenter.defaultCenter()
        
        // 键盘出现时
        center.addObserver(self, selector: "handleKeyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        
        // 键盘消失时
        center.addObserver(self, selector: "handleKeyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    // 视图消失时调用
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        // 移除消息监听
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 编写事件处理方法
    func handleKeyboardWillShow(notification: NSNotification) {
        let userInfo = notification.userInfo
        
        if let info = userInfo {
            // 动画持续时间
            let animationDurationObject = info[UIKeyboardAnimationDurationUserInfoKey] as! NSValue
            
            // 键盘尺寸
            let keyboardEndRectObject = info[UIKeyboardFrameEndUserInfoKey] as! NSValue
            
            var animationDuration = 0.0
            var keyboardEndRect = CGRectZero
            
            animationDurationObject.getValue(&animationDuration)
            keyboardEndRectObject.getValue(&keyboardEndRect)
            
            let window = UIApplication.sharedApplication().keyWindow
            keyboardEndRect = view.convertRect(keyboardEndRect, fromView: window)
            
            let intersectionOfKeyboardRectAndWindowRect = CGRectIntersection(view.frame, keyboardEndRect)
            
            UIView.animateWithDuration(animationDuration, animations: { [weak self] in
                self?.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: intersectionOfKeyboardRectAndWindowRect.size.height, right: 0)
                self?.scrollView.scrollRectToVisible(self!.textField.frame, animated: false)
                })
        }
        
    }
    
    func handleKeyboardWillHide(sender: NSNotification) {
        let userInfo = sender.userInfo
        
        if let info = userInfo {
            let animationDurationObject = info[UIKeyboardAnimationDurationUserInfoKey] as! NSValue
            var animationDuration = 0.0
            
            animationDurationObject.getValue(&animationDuration)
            UIView.animateWithDuration(animationDuration, animations: {
                [weak self] in
                self!.scrollView.contentInset = UIEdgeInsetsZero
                })
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

