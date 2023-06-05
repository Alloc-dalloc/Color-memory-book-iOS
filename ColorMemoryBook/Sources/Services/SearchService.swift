//
//  SearchService.swift
//  ColorMemoryBook
//
//  Created by 임영준 on 2023/06/03.
//

import Moya
import UIKit

enum SearchService{
    case search(keyword: String?, cursor: Int?)
}

extension SearchService: BaseTargetType {
    
    var path: String {
        switch self {
        case .search:
            return "/api/color-memory-book/search"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .search:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case let .search(keyword, cursor):
            var parameters: [String: Any] = [:]

            if let keyword = keyword {
                parameters["keyword"] = keyword
            }

            if let cursor = cursor {
                parameters["cursor"] = cursor
            }

            return .requestParameters(
                parameters: parameters,
                encoding: URLEncoding.default
            )
        }
    }
}
