//
//  MemoryListViewModel.swift
//  ColorMemoryBook
//
//  Created by 임영준 on 2023/04/23.
//

import UIKit
import RxSwift

class MemoryListViewModel{ 
    
    lazy var memoryObservable = BehaviorSubject<[Memory]>(value: [])
    lazy var searchTextSubject = BehaviorSubject<String>(value: "")
    
    lazy var filteredMemoryObservable: Observable<[Memory]> = {
        return Observable.combineLatest(memoryObservable, searchTextSubject.asObservable())
            .map { [weak self] memories, searchText in
                guard let self = self else {return []}
                return self.searchMemories(searchText: searchText, memories: memories)
            }
    }()
    
    init(){
        let memories:[Memory] = [
            Memory(image: UIImage(named: "tmp1")!, tag: "1번 샘플", color: "빨간색", description: "1번 dec"),
            Memory(image: UIImage(named: "tmp2")!, tag: "2번 샘플", color: "파란색", description: "2번 dec"),
            Memory(image: UIImage(named: "tmp3")!, tag: "3번 샘플", color: "노란색", description: "3번 dec"),
            Memory(image: UIImage(named: "tmp4")!, tag: "4번 샘플", color: "초록색 ", description: "4번 dec")
        ]
        memoryObservable.onNext(memories)
    }
    
    func searchMemories(searchText: String, memories: [Memory]) -> [Memory] {
        if searchText.isEmpty {
            return memories
        } else {
            return memories.filter { $0.tag.contains(searchText) }
        }
    }
}
 
 
