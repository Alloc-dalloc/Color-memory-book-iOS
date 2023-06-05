//
//  DefaultSearchRepository.swift
//  ColorMemoryBook
//
//  Created by 김윤서 on 2023/06/05.
//

import Foundation
import Moya
import RxMoya
import RxSwift

protocol SearchRepository {
    func fetchList(keyword: String?, cursor: Int?) -> Observable<[MemoryDTO]>
}

final class DefaultSearchRepository: SearchRepository {
    let router: MoyaProvider<SearchService>

    init() {
        self.router = MoyaProvider<SearchService>(
            plugins: [NetworkLogPlugin()]
        )
    }

    func fetchList(keyword: String?, cursor: Int?) -> Observable<[MemoryDTO]> {
        return router.rx.request(.search(keyword: keyword, cursor: cursor))
            .asObservable()
            .map([MemoryDTO].self)

    }
}

