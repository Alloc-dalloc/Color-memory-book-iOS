//
//  MemoryListViewModel.swift
//  ColorMemoryBook
//
//  Created by 임영준 on 2023/04/23.
//

import UIKit

import RxCocoa
import RxSwift

class MemoryListViewModel{ 
    // MARK: - Input
    let searchTextSubject = PublishSubject<String>()
    let viewWillAppear = PublishSubject<Void>()

    // MARK: - Output
    let list: Driver<[MemoryDTO]>

    private let searchRepository: SearchRepository

    init(searchRepository: SearchRepository){
        self.searchRepository = searchRepository

        let viewWillAppear = searchRepository
            .fetchList(keyword: nil, cursor: nil)

        let search = searchTextSubject
            .flatMap { keyword in
                return searchRepository.fetchList(keyword: keyword, cursor: nil)
            }

        list = Observable.merge(viewWillAppear, search)
            .asDriver(onErrorJustReturn: [])
    }
}
 
 
