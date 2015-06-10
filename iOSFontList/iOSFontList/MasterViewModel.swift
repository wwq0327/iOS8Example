//
//  MasterViewModel.swift
//  iOSFontList
//
//  Created by wyatt on 15/6/10.
//  Copyright (c) 2015年 Wanqing Wang. All rights reserved.
//

import UIKit

class MasterViewModel {
    var familyNames: [String]
    var fonts = [String: [String]]()
    
    init() {
        let unsortedFamilyNames = UIFont.familyNames() as! [String]
        familyNames = sorted(unsortedFamilyNames)
        
        let sorter = FontSorter()
        for familyName in familyNames {
            let unsortedFamilyNames = UIFont.fontNamesForFamilyName(familyName) as! [String]
            fonts[familyName] = sorter.sortFontNames(unsortedFamilyNames)
        }
    }
    
    func numberOfSections() -> Int {
        return count(familyNames)
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        // 取出相应字体的key
        let key = familyNames[section]
        // 取出值
        let array = fonts[key]!
        return count(array)
    }
    
    func titleAtIndexPath(indexPath: NSIndexPath) -> String {
        let key = familyNames[indexPath.section]
        let array = fonts[key]
        let fontName = array![indexPath.row]
        return fontName
    }
}
