//
//  HiddenButton.swift
//  ColorMemoryBook
//
//  Created by 임영준 on 2023/04/23.
//

import UIKit

final class HiddenButton: UIButton {
    
    init(title: String){
        super.init(frame: .zero)
        self.backgroundColor = UIColor.ohsogo_Charcol
        self.titleLabel?.text = title
        setLayouts()
    }
    
    private func setLayouts(){
        self.snp.makeConstraints {
            $0.height.equalTo(49)
            $0.width.equalTo(134)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 8
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
}
