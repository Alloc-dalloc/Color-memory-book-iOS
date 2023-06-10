//
//  ImageInfo.swift
//  ColorMemoryBook
//
//  Created by 임영준 on 2023/06/02.
//

import Foundation

struct ImageInfo: Decodable {
    let colorAnalysis: [ColorAnalysis]
    let labels: [Label]
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case colorAnalysis, labels
        case imageURL = "imageUrl"
    }
}

// MARK: - ColorAnalysis
struct ColorAnalysis: Codable {
    let colorName: String
    let colorPercentage: Int
}

// MARK: - Label
struct Label: Codable {
    let name: String
    let confidence: Double
}
