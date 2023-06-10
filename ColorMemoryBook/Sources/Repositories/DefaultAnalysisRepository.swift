//
//  DefaultAnalysisRepository.swift
//  ColorMemoryBook
//
//  Created by 임영준 on 2023/06/05.
//

import Foundation
import Moya
import RxMoya
import RxSwift

protocol AnalysisRepository {
    func fetchImageInfo(imageData: Data) -> Observable<ImageInfo>
}

final class DefaultAnalysisRepository: AnalysisRepository {
    
    let router: MoyaProvider<PostService>

    init() {
        self.router = MoyaProvider<PostService>(
            plugins: [NetworkLogPlugin()]
        )
    }
    
    //image데이터를 받아서 imageinfo 형태의 observable을 반환
    func fetchImageInfo(imageData: Data) -> RxSwift.Observable<ImageInfo> {
        return router.rx.request(.analysisImage(imageData: imageData))
            .asObservable()
            .map(ImageInfo.self)
    }
}
