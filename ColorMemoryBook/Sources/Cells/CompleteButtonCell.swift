//
//  CompleteButtonCell.swift
//  ColorMemoryBook
//
//  Created by 임영준 on 2023/05/20.
//

import UIKit

class CompleteButtonCell: UICollectionViewCell {
   
    let completeButton = UIButton().then{
        $0.backgroundColor = .ohsogo_Blue
        $0.setTitle("완료", for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        $0.setTitleColor(UIColor.white, for: .normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setLayout(){
        contentView.addSubview(completeButton)
        completeButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}

#if DEBUG

import SwiftUI

struct CompleteButtonCell_Previews: PreviewProvider {
    static var previews: some View {
        CompleteButtonCell().getPreview()
            .previewLayout(.fixed(width: 200, height: 100))
    }
}

#endif
