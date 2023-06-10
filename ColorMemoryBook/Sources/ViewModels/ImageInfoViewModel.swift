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
    let doneButtonDidTap = PublishSubject<WritingMemory>()

    // MARK: - Output
    let detail: Driver<ImageInfo?>
    let isCompletedUpload: Driver<MemoryDetail2DTO?>

    private let analaysisRepository: AnalysisRepository
    private let postRepository: PostRepository

    init(analysisRepository: AnalysisRepository, postRepository: PostRepository){
        self.analaysisRepository = analysisRepository
        self.postRepository = postRepository

        detail = viewWillAppear
            .flatMap { analysisRepository.fetchImageInfo(imageData: $0) }
            .compactMap { $0 }
            .asDriver(onErrorJustReturn: nil)

        isCompletedUpload = doneButtonDidTap
            .flatMap { postRepository.saveWriting($0) }
            .compactMap { $0 }
            .asDriver(onErrorJustReturn: nil)
    }
}
