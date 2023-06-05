//
//  ImageAnalysisService.swift
//  ColorMemoryBook
//
//  Created by 임영준 on 2023/06/01.
//

import Moya
import UIKit

enum PostService{
    case analysisImage(imageData: Data)
    case registerMemoryBook(imageUrl: URL)
}

extension PostService: BaseTargetType {
    var headers: [String: String]? {
        switch self {
        case .analysisImage:
            return [
                "Content-Type": "multipart/form-data",
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
            return .post
        case .registerMemoryBook:
            return .post
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
 
