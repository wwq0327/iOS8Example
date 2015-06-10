//
//  DetailViewController.swift
//  iOSFontList
//
//  Created by wyatt on 15/6/10.
//  Copyright (c) 2015年 Wanqing Wang. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var indexPath = NSIndexPath()
    
    let viewModel = MasterViewModel()
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var fontSize: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fontName = viewModel.titleAtIndexPath(indexPath)
        textView.font = UIFont(name: fontName, size: 12)
    }
    
    @IBAction func sliderFontSize(sender: UISlider) {
        var size = Int(sender.value)
        fontSize.text = "\(size)"
        let fontName = viewModel.titleAtIndexPath(indexPath)
        textView.font = UIFont(name: fontName, size: CGFloat(size))
    }
    
    
}
