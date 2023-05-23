//
//  EditableTagCell.swift
//  ColorMemoryBook
//
//  Created by 임영준 on 2023/05/20.
//

import UIKit
import WSTagsField

class EditableTagCell: UICollectionViewCell {
    
    let tagBackgoundView = UIView().then{
        $0.backgroundColor = UIColor.ohsogo_Gray
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
    }
    
    let circleView = UIView().then{
        $0.backgroundColor = .white
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 5
    }
    
    let tagsField = WSTagsField().then{
        $0.placeholderAlwaysVisible = true
        $0.placeholder = "태그 추가"
        $0.textField.returnKeyType = .continue
        $0.placeholderColor = .black
        
        $0.tintColor = .ohsogo_Gray
        $0.textColor = .black
        $0.selectedColor = .ohsogo_Gray2
        $0.selectedTextColor = .white

        $0.delimiter = ""
        $0.spaceBetweenTags = 13
        $0.spaceBetweenLines = 20
    }
    
    func setProperties(){
        tagsField.onDidSelectTagView = { field, tag in
            print("삭제 어떻게 하는데")
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
        setProperties()
    }
    
    func setLayout(){
        contentView.addSubviews(tagsField)
        tagsField.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
    

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}



