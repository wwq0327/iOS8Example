//
//  ViewController.swift
//  ViewControllerLifecycle
//
//  Created by wyatt on 15/5/1.
//  Copyright (c) 2015年 Wanqing Wang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // 1.视图加载时调用
    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog("viewDidLoad")
    }
    
    // 2.视图呈现前调用
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        NSLog("viewWillAppear")
    }
    
    // 3.视图呈现后调用
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        NSLog("viewDidAppear")
    }
    
    // 4.视图结束前，要切换到下一视图前调用
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSLog("viewWillDisappear")
    }
    
    // 5.视图结束前，要切换到下一视图时调用
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        NSLog("viewDidDisappear")
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        NSLog("didReceiveMemoryWarning")
    }


}

