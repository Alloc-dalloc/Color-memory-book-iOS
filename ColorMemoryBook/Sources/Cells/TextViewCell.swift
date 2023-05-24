//
//  TextViewCell.swift
//  ColorMemoryBook
//
//  Created by 임영준 on 2023/05/15.
//

import UIKit
import SnapKit
import Then

final class TextViewCell: UICollectionViewCell {
    let textView = UITextView().then{
        $0.textContainer.maximumNumberOfLines = 0
        $0.backgroundColor = UIColor.ohsogo_Gray
        $0.text = "하이하이하이하이하이하이하이하이하이하이하이하이하이하이하이하이하이하이하이하이하이하이하이하이하이하이하이하이하이하이하이하이하이하"
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.isEditable = false
        $0.sizeToFit()
        $0.isScrollEnabled = false
        $0.textContainerInset = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
        $0.layer.cornerRadius = 8
    }
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setLayout(){
        contentView.addSubview(textView)
        textView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

#if DEBUG

import SwiftUI

struct TextViewCell_Previews: PreviewProvider {
    static var previews: some View {
        TextViewCell().getPreview()
            .previewLayout(.fixed(width: 200, height: 100))
    }
}

#endif

