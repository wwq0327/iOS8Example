//: Playground - noun: a place where people can play

import UIKit

// 字体名称
var familyNames = UIFont.familyNames() as! [String]

var label = UILabel(frame: CGRectMake(0, 0, 400, 30))

for familyName in sorted(familyNames) {
    // 字体的样式
    for fontName in UIFont.fontNamesForFamilyName(familyName as String) {
        label.text = "\(fontName): Hello, world, 你好，世界"
        label.font = UIFont(name: fontName as! String, size: 20)
    }
}



