//
//  DiaryCollectionViewCell.swift
//  Diary
//
//  Created by wyatt on 15/6/14.
//  Copyright (c) 2015年 Wanqing Wang. All rights reserved.
//

import UIKit

class DiaryCollectionViewCell: UICollectionViewCell {
    var textLabel: DiaryLabel!
    
    var labelText: String = "" {
        didSet {
            self.textLabel.updateText(labelText)
            self.textLabel.center = CGPointMake(itemWidth/2.0, self.textLabel.center.y + 28)
        }
    }
    
    var textInt: Int = 0
    
    override func awakeFromNib() {
        var lineHeight: CGFloat = 5.0
        self.textLabel = DiaryLabel(fontname: "Wyue-GutiFangsong-NC", labelText: labelText, fontSize: 16.0, lineHeight: lineHeight)
        
        self.addSubview(textLabel)
    }
}
