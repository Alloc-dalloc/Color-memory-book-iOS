//
//  ColorFilterButton.swift
//  ColorMemoryBook
//
//  Created by 임영준 on 2023/04/17.
//

import UIKit
import SnapKit

final class ColorFilterButton: UIButton {
    
    let buttonColor : UIColor
    
    init(color: UIColor){
        self.buttonColor = color
        super.init(frame: .zero)
        setProperties()
        setLayouts()
    }
    
    private func setLayouts(){
        self.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.width.equalTo(30)
        }
    }
    
    private func setProperties(){
        self.backgroundColor = buttonColor
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.clear.cgColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.width / 2
    }
    
    override var isSelected: Bool {
        didSet{
            layer.borderColor = isSelected ? UIColor.white.cgColor : UIColor.clear.cgColor
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has fnot been implemented")
    }
    
}
