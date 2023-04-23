//
//  ColorFilterButton.swift
//  ColorMemoryBook
//
//  Created by 임영준 on 2023/04/17.
//

import UIKit
import SnapKit

final class ColorFilterButton: UIButton {
    
    var buttonColor = UIColor()
    
    init(color: UIColor){
        super.init(frame: .zero)
        self.buttonColor = color
        self.backgroundColor = buttonColor
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.clear.cgColor
        setLayouts()
    }
    
    private func setLayouts(){
        print(#fileID, #function, #line, "- ")
        self.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.width.equalTo(30)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.width / 2
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has fnot been implemented")
    }
    
}
