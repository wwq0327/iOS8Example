//
//  ViewController.swift
//  LayerDemo
//
//  Created by wyatt on 15/5/9.
//  Copyright (c) 2015年 Wanqing Wang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var profileImageview: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // 设置倒角，可以直接设置倒角的值
        profileImageview.layer.cornerRadius = self.profileImageview.frame.size.width / 2
        self.profileImageview.clipsToBounds = true
        
        // 设置边框及颜色
        profileImageview.layer.borderWidth = 3.0
        profileImageview.layer.borderColor = UIColor.whiteColor().CGColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

