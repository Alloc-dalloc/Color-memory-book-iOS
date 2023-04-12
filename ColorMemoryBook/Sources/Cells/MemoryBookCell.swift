//
//  MemoryBookCell.swift
//  ColorMemoryBook
//
//  Created by 임영준 on 2023/04/12.
//

import Foundation
import UIKit

class MemoryBookCell: UICollectionViewCell{
    
    let thumbnailImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.image = UIImage(named: "tmp")
        imageView.backgroundColor = UIColor.lightGray
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(thumbnailImageView)
        
        thumbnailImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
 
#if DEBUG

import SwiftUI

struct MemoryBookCell_Previews: PreviewProvider {
    static var previews: some View {
        MemoryBookCell().getPreview()
            .previewLayout(.fixed(width: 200, height: 100))
    }
}

#endif

