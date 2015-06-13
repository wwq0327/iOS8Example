//
//  DiaryLayout.swift
//  Diary
//
//  Created by wyatt on 15/6/13.
//  Copyright (c) 2015年 Wanqing Wang. All rights reserved.
//

import UIKit

class DiaryLayout: UICollectionViewFlowLayout {
    override func prepareLayout() {
        super.prepareLayout()
        let itemSize = CGSizeMake(itemWidth, itemHeight)
        self.itemSize = itemSize
        self.minimumInteritemSpacing = 0.0
        self.minimumLineSpacing = 0
    }
}
