//
//  ViewController.swift
//  KeyboardNotification
//
//  Created by wyatt on 15/5/1.
//  Copyright (c) 2015年 Wanqing Wang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    
    // 加载视图时调用
    override func viewDidLoad() {
        super.viewDidLoad()
//        textField.becomeFirstResponder()
    }
    
    // 视图呈现时
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // 消息中接收中心
        let notificationCenter = NSNotificationCenter.defaultCenter()
        
        // 键盘出现时
        notificationCenter.addObserver(self, selector: "handleKeyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        
        // 键盘出现后
        notificationCenter.addObserver(self, selector: "handleKeyboardDidShow:", name: UIKeyboardDidShowNotification, object: nil)
        
        // 键盘消失时
        notificationCenter.addObserver(self, selector: "handleKeyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        
        // 键盘消失后
        notificationCenter.addObserver(self, selector: "handleKeyboardDidHide:", name: UIKeyboardDidHideNotification, object: nil)
    }
    
    func handleKeyboardWillShow(notification: NSNotification) {
        
        NSLog("键盘显示时")
    }
    
    func handleKeyboardDidShow(notification: NSNotification) {
        NSLog("键盘显示后")
    }
    
    func handleKeyboardWillHide(notification: NSNotification) {
        NSLog("键盘消失时")
    }
    
    func handleKeyboardDidHide(notification: NSNotification) {
        NSLog("键盘消失后")
    }
    
    // 视图消失前
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}

