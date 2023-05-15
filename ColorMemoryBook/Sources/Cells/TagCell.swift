//
//  TagCollectionViewCell.swift
//  ColorMemoryBook
//
//  Created by 임영준 on 2023/05/05.
//

import UIKit

final class TagCollectionViewCell: UICollectionViewCell {
    let backgoundView = UIView().then{
        $0.backgroundColor = UIColor.ohsogo_Gray
    }
    
    let circleView = UIView().then{
        $0.backgroundColor = .clear
    }
    
    
}
