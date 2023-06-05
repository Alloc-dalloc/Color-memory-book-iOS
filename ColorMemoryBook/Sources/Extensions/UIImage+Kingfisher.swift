//
//  UIImage+Kingfisher.swift
//  ColorMemoryBook
//
//  Created by 김윤서 on 2023/06/05.
//

import UIKit

import Kingfisher

public extension UIImageView {

    /// Kingfisher 이미지 처리
    /// - Parameters:
    ///   - url: 이미지 URL
    ///   - defaultImage: 디폴트 이미지!!
    ///   - handler: 이미지 로딩 후 completion handler
    func image(url: String?, defaultImage: UIImage? = UIImage(), handler: (() -> Void)? = nil) {
        kf.indicatorType = .activity
        guard let url = URL(string: url ?? "") else {
            image = defaultImage
            return
        }
        kf.setImage(
            with: url,
            placeholder: .none,
            options: [
                .transition(ImageTransition.fade(0.5)),
                .backgroundDecode,
                .alsoPrefetchToMemory,
                .cacheMemoryOnly
            ]) { _ in
                handler?()
            }
    }

    func cancelDownloadTask() {
        kf.cancelDownloadTask()
    }
}
