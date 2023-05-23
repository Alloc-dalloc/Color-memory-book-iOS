//
//  MemoryImageCell.swift
//  ColorMemoryBook
//
//  Created by 임영준 on 2023/05/05.
//

import UIKit
import SnapKit
import Then

class MemoryImageCell: UICollectionViewCell {
    let imageView = UIImageView().then{
        $0.backgroundColor = .ohsogo_Gray
        $0.contentMode = .scaleAspectFill
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayouts()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    

    func setLayouts(){
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

#if DEBUG

import SwiftUI

struct MemoryImageCell_Previews: PreviewProvider {
    static var previews: some View {
        MemoryImageCell().getPreview()
            .previewLayout(.fixed(width: 200, height: 100))
    }
}

#endif

