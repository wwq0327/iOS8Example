//
//  CollectionViewCell.swift
//  Diary
//
//  Created by wyatt on 15/6/13.
//  Copyright (c) 2015年 Wanqing Wang. All rights reserved.
//

import UIKit

class HomeYearCollectionViewCell: UICollectionViewCell {
    var textLabel: DiaryLabel!
    var textInt: Int = 0
    var labelText: String = "" {
        didSet {
            self.textLabel.updateText(labelText)
        }
    }
    
    override func awakeFromNib() {
        self.textLabel = DiaryLabel(fontname: "TpldKhangXiDictTrial", labelText: labelText, fontSize: 16.0, lineHeight: 5.0)
        self.addSubview(textLabel)
    }
    
    override func layoutSubviews() {
        self.textLabel.center = CGPointMake(itemWidth/2.0, 150.0/2.0)
    }
}
