//
//  HeaderView.swift
//  ColorMemoryBook
//
//  Created by 임영준 on 2023/05/15.
//

import UIKit
import SnapKit
import Then

class HeaderView: UICollectionReusableView {
    let titleLabel = UILabel().then{
        $0.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setLayout(){
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
        }
    }
}
