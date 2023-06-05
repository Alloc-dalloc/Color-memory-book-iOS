//
//  SearchService.swift
//  ColorMemoryBook
//
//  Created by 임영준 on 2023/06/03.
//

import Moya
import UIKit

enum SearchService{
    case analysisImage(imageData: Data)
    case registerMemoryBook(idToken: String)
}

extension SearchService: BaseTargetType {
    var headers: [String: String]? {
        switch self {
        case .analysisImage:
            return [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(UserDefaultHandler.shared.accessToken)"
            ]
        default:
            return [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(UserDefaultHandler.shared.accessToken)"
            ]
        }
    }
    
    var path: String {
        switch self {
        case .analysisImage:
            return "/api/image/analysis"
        case .registerMemoryBook:
            return "/api/color-memory-book/register"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .analysisImage:
            return .get
        case .registerMemoryBook:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case let .analysisImage(imageData):
            let data = MultipartFormData(
                provider: .data(imageData),
                name: "image",
                fileName: "image.jpeg",
                mimeType: "image/jpeg"
            )
            return .uploadMultipart([data])
            
        case let .registerMemoryBook(idToken):
            return .requestJSONEncodable(idToken)
        }
    }
}
