//
//  DiaryHelper.swift
//  Diary
//
//  Created by wyatt on 15/6/14.
//  Copyright (c) 2015年 Wanqing Wang. All rights reserved.
//

import UIKit

let defaultFont = "Wyue-GutiFangsong-NC"

let screenRect = UIScreen.mainScreen().bounds
let DiaryRed = UIColor(red: 192.0/255.0, green: 23.0/255.0, blue: 48.0/255.0, alpha: 1.0)
let DiaryFont = UIFont(name: defaultFont, size: 18.0) as UIFont!
let DiaryLocationFont = UIFont(name: defaultFont, size: 16.0) as UIFont!
let DiaryTitleFont = UIFont(name: defaultFont, size: 18.0) as UIFont!

// CoreData 数据库配置
let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
let managedContext = appDelegate.managedObjectContext!

// storyboard identifiers
struct StoryboardIdentifiers {
    static let diaryYearIdentifiers = "DiaryYearCollectionViewController"
    static let diaryMonthIdentifiers = "DiaryMonthDayCollectionViewController"
    static let diaryComposeViewController = "DiaryComposeViewController"
    static let diaryViewController = "DiaryViewController"
}

// colletioncell indetifiers
struct CollectionCellIdetifiers {
    // home视图中的cell
    static let homeYearCellIdentifiers = "HomeYearCollectionViewCell"
    // 二级中cell
    static let diaryCellIdentifiers = "DiaryCollectionViewCell"
}
// 创建自定义按钮
func diaryButtonWith(#text: String, #fontSize: CGFloat, #width: CGFloat, #normalImageName: String, #highlightedImageName: String) -> UIButton {
    var button = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
    
    button.frame = CGRectMake(0, 0, width, width)
    var font = UIFont(name: "Wyue-GutiFangsong-NC", size: fontSize) as UIFont!
    
    let textAttributes: [NSObject: AnyObject] = [NSFontAttributeName: font, NSForegroundColorAttributeName: UIColor.whiteColor()]
    
    var attributedText = NSAttributedString(string: text, attributes: textAttributes)
    button.setAttributedTitle(attributedText, forState: UIControlState.Normal)
    
    // 按钮的正常图片背景及高亮背景
    button.setBackgroundImage(UIImage(named: normalImageName), forState: UIControlState.Normal)
    button.setBackgroundImage(UIImage(named: highlightedImageName), forState: UIControlState.Highlighted)
    
    return button
}

// 将数字日期转换为中文的汉字日期
func numberToChinese(number: Int) -> String {
    var numbers = Array(String(number))
    var finalString = ""
    for singleNumber in numbers {
        var string = singleNumberToChinese(singleNumber)
        finalString = "\(finalString)\(string)"
    }
    
    return finalString
}

// 带单位的中文数字
func numberToChineseWithUnit(number: Int) -> String {
    var numbers = Array(String(number))
    var units = unitParser(numbers.count)
    var finalString = ""
    
    for (index, singleNumber) in enumerate(numbers) {
        var string = singleNumberToChinese(singleNumber)
        if (!(string == "零" && (index+1) == numbers.count)) {
            finalString = "\(finalString)\(string)\(units[index])"
        }
    }
    return finalString
}

func unitParser(unit: Int) -> [String] {
    var units = ["万", "千", "百", "十", ""].reverse()
    var sliceUnits: ArraySlice<String> = units[0..<(unit)].reverse()
    var final: [String] = Array(sliceUnits)
    return final
}

func singleNumberToChinese(number: Character) -> String {
    switch number {
    case "0":
        return "零"
    case "1":
        return "一"
    case "2":
        return "二"
    case "3":
        return "三"
    case "4":
        return "四"
    case "5":
        return "五"
    case "6":
        return "六"
    case "7":
        return "七"
    case "8":
        return "八"
    case "9":
        return "九"
    default:
        return ""
    }
}



