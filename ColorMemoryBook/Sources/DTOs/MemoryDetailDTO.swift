//
//  MemoryDetailDTO.swift
//  ColorMemoryBook
//
//  Created by 김윤서 on 2023/06/05.
//

import Foundation

// MARK: - Welcome
struct MemoryDetailDTO: Codable {
    let id: Int
    let imageURL: String
    let description: String
    let tags: [Tag]

    enum CodingKeys: String, CodingKey {
        case id
        case imageURL = "imageUrl"
        case description, tags
    }
}

// MARK: - Tag
struct Tag: Codable {
    let id: Int
    let tagName: String
}
