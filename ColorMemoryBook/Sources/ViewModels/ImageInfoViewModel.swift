//
//  ImageInfoViewModel.swift
//  ColorMemoryBook
//
//  Created by 임영준 on 2023/06/05.
//

import UIKit

import RxCocoa
import RxSwift


class ImageInfoViewModel{
    // MARK: - Input
    let viewWillAppear = PublishSubject<Data>()

    // MARK: - Output
    let detail: Driver<ImageInfo?>

    private let analaysisRepository: AnalysisRepository

    init(analysisRepository: AnalysisRepository){
        self.analaysisRepository = analysisRepository

        detail = viewWillAppear
            .flatMap { analysisRepository.fetchImageInfo(imageData: $0) }
            .compactMap { $0 }
            .asDriver(onErrorJustReturn: nil)
    }
}
