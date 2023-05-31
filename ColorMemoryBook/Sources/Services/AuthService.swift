//
//  AuthRepository.swift
//  ColorMemoryBook
//
//  Created by 임영준 on 2023/05/31.
//

import Moya

enum AuthService{
    case refresh(refreshToken: String, accessToken: String)
    case login(idToken: String)
}

extension AuthService: BaseTargetType {
    var headers: [String: String]? {
        switch self {
        case .login:
            return [
                "Content-Type": "application/json"
            ]
        case .refresh:
            return [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(UserDefaultHandler.shared.accessToken)"
            ]
        }
    }

    var path: String {
        switch self {
        case .refresh:
            return "/auth/refresh"
        case .login:
            return "/api/auth/apple"
        }
    }

    var method: Moya.Method {
        switch self {
        case .refresh:
            return .post
        case .login:
            return .post
        }
    }

    var task: Task {
        switch self {
        case let .login(idToken):
            return .requestParameters(
                parameters: ["token": idToken],
                encoding: JSONEncoding.default
            )
        default:
            return .requestPlain
        }
    }
}
