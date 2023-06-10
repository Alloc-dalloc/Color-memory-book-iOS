//
//  EditableTagCell.swift
//  ColorMemoryBook
//
//  Created by 임영준 on 2023/05/20.
//

import UIKit
import WSTagsField

protocol EditableTagCellDelegate: AnyObject {
    func onDidAddTag(_ tags: [String])
}

final class EditableTagCell: UICollectionViewCell {
    weak var delegate: EditableTagCellDelegate?
    
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
        tagsField.onDidAddTag = { [weak self] _, _ in
            guard let self = self else { return }
            self.delegate?.onDidAddTag(self.tagsField.tags.compactMap { $0.text })
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



