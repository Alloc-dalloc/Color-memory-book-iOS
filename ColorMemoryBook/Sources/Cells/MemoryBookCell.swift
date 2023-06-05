//
//  MemoryBookCell.swift
//  ColorMemoryBook
//
//  Created by 임영준 on 2023/04/12.
//

import UIKit
import SnapKit
import Then

final class MemoryBookCell: UICollectionViewCell{
    
    var thumbnailImage: UIImage!
    
    private let thumbnailImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
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

    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure(with image: UIImage) {
        thumbnailImage = image
        thumbnailImageView.image = thumbnailImage
    }

    func configure(with imageURL: String) {
        thumbnailImageView.image(url: imageURL)
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

