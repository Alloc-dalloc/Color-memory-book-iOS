//
//  MemoryBookViewModel.swift
//  ColorMemoryBook
//
//  Created by 김윤서 on 2023/06/05.
//

import UIKit

import RxCocoa
import RxSwift

class MemoryBookViewModel{
    // MARK: - Input
    let viewWillAppear = PublishSubject<Int>()

    // MARK: - Output
    let detail: Driver<MemoryDetailDTO?>

    private let postRepository: PostRepository

    init(postRepository: PostRepository){
        self.postRepository = postRepository

        detail = viewWillAppear
            .flatMap { postRepository.fetchDetail(postID: $0) }
            .compactMap { $0 }
            .asDriver(onErrorJustReturn: nil)
    }
}


