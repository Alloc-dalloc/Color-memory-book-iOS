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


struct MemoryDetail2DTO: Codable {
    let materialID: Int
    let imageURL: String
    let tagList: [Tag2]
    let description: String

    enum CodingKeys: String, CodingKey {
        case materialID = "materialId"
        case imageURL = "imageUrl"
        case tagList, description
    }
}

// MARK: - TagList
struct Tag2: Codable {
    let tagID: Int
    let tagName: String

    enum CodingKeys: String, CodingKey {
        case tagID = "tagId"
        case tagName
    }
}
