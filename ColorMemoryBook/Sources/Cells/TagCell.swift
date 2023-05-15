//
//  TagCollectionViewCell.swift
//  ColorMemoryBook
//
//  Created by 임영준 on 2023/05/05.
//

import UIKit

final class TagCell: UICollectionViewCell {
    
    let backgoundView = UIView().then{
        $0.backgroundColor = UIColor.ohsogo_Gray
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
    }
    
    let circleView = UIView().then{
        $0.backgroundColor = .white
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 5
    }
    
    let tagLabel = UILabel().then{
        $0.text = "tmp"
        $0.textColor = UIColor.ohsogo_Gray2
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayouts()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    

    func setLayouts(){
        contentView.addSubview(backgoundView)
        backgoundView.addSubviews(circleView, tagLabel)
        backgoundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        circleView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.centerX.equalTo(backgoundView.snp.leading)
            $0.size.equalTo(10)
        }
        tagLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        
    }
}

#if DEBUG

import SwiftUI
struct TagCell_Previews: PreviewProvider {
    static var previews: some View {
        TagCell().getPreview()
            .previewLayout(.fixed(width: 100, height: 40))
    }
}
#endif
