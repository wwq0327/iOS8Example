//
//  MasterViewController.swift
//  iOSFontList
//
//  Created by wyatt on 15/6/10.
//  Copyright (c) 2015年 Wanqing Wang. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {
    

    let viewModel = MasterViewModel()
    
    // cell id
    struct TableCellIndentifier {
        static let fontCellIndentifier = "NameCell"
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(TableCellIndentifier.fontCellIndentifier, forIndexPath: indexPath) as! UITableViewCell
        
        cell.textLabel?.text = viewModel.titleAtIndexPath(indexPath)
        cell.textLabel?.font = fontAtIndexPath(indexPath)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let label = UILabel(frame: CGRectMake(0, 0, 280, 200))
        label.text = viewModel.titleAtIndexPath(indexPath)
        label.font = fontAtIndexPath(indexPath)
        label.sizeToFit()
        return max(label.font.lineHeight + label.font.ascender + -label.font.descender, 44)
    }
    
    
    func fontAtIndexPath(indexPath: NSIndexPath) -> UIFont {
        let fontName = viewModel.titleAtIndexPath(indexPath)
        // 字体及系统字号
        return UIFont(name: fontName, size: UIFont.systemFontSize())!
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "show Font" {
            let vc = segue.destinationViewController as! DetailViewController
            if let indexPath = tableView.indexPathForSelectedRow() {
                vc.indexPath = indexPath
            }
        }
    }



}
