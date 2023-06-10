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
    case detail(postID: Int)
    case postWritng(_ memory: WritingMemory)
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
        case let .detail(postID):
            return "/api/color-memory-book/detail/\(postID)"
        case .postWritng(_):
            return "/api/color-memory-book/register"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .analysisImage:
            return .post
        case .detail:
            return .get
        case .postWritng:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case let .analysisImage(imageData):
            let data = MultipartFormData(
                provider: .data(imageData),
                name: "image",
                fileName: "image.png",
                mimeType: "image/png"
            )
            return .uploadMultipart([data])
            
        case .detail:
            return .requestPlain

        case let .postWritng(memory):
            return .requestJSONEncodable(memory)
        }
    }
}
 
