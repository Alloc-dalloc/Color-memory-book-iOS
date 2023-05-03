//
//  HiddenButton.swift
//  ColorMemoryBook
//
//  Created by 임영준 on 2023/04/23.
//

import UIKit

final class HiddenButton: UIButton {
    
    let titleText : String
    
    init(title: String){
        self.titleText = title
        super.init(frame: .zero)
        setProperties()
        setLayouts()
    }
    
    private func setLayouts(){
        self.snp.makeConstraints {
            $0.height.equalTo(49)
            $0.width.equalTo(134)
        }
    }
    
    private func setProperties(){
        self.backgroundColor = UIColor.ohsogo_Charcol
        self.setTitle(titleText, for: .normal)
        self.titleLabel?.textColor = .white
        self.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        self.isHidden = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.clipsToBounds = true
        self.layer.cornerRadius = 8
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
}
