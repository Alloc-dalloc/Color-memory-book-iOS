//
//  DefaultPostRepository.swift
//  ColorMemoryBook
//
//  Created by 김윤서 on 2023/06/05.
//

import Foundation
import Moya
import RxMoya
import RxSwift

protocol PostRepository {
    func fetchDetail(postID: Int) -> Observable<MemoryDetailDTO>
    func saveWriting(_ writingMemory: WritingMemory) -> Observable<MemoryDetail2DTO>
}

final class DefaultPostRepository: PostRepository {

    let router: MoyaProvider<PostService>

    init() {
        self.router = MoyaProvider<PostService>(
            plugins: [NetworkLogPlugin()]
        )
    }

    func fetchDetail(postID: Int) -> Observable<MemoryDetailDTO> {
        return router.rx.request(.detail(postID: postID))
            .asObservable()
            .map(MemoryDetailDTO.self)
    }

    func saveWriting(_ writingMemory: WritingMemory) -> RxSwift.Observable<MemoryDetail2DTO> {
        return router.rx.request(.postWritng(writingMemory))
            .asObservable()
            .map(MemoryDetail2DTO.self)
    }


}
