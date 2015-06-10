//
//  FontSorter.swift
//  iOSFontList
//
//  Created by wyatt on 15/6/10.
//  Copyright (c) 2015年 Wanqing Wang. All rights reserved.
//

import Foundation


class FontSorter {
    func sortFontNames(array: [String]) -> [String] {
        let predicate = { (s1: String, s2: String) -> Bool in
            // componentsSeparatedByString 对字符进行分段
            let count1 = count(s1.componentsSeparatedByString("-"))
            // 与1进行比较，如果不为1，则为真，否则为假
            let s1ContainsHyphen = count1 != 1
            
            let count2 = count(s2.componentsSeparatedByString("-"))
            let s2containsHyphen = count2 != 1
            
            if (s1ContainsHyphen && s2containsHyphen) {
                return s1 < s2
            } else {
                if !s1ContainsHyphen {
                    return true
                }
                
                if !s2containsHyphen {
                    return false
                }
            }
            return s1 < s2
        }
        
        return sorted(array, predicate)
    }
}