//
//  ImageInfo.swift
//  ColorMemoryBook
//
//  Created by 임영준 on 2023/06/02.
//

import Foundation

struct ImageInfo: Decodable {
    let imageURL: String
    let labels: [Label]
    let colorAnalysis: [ColorAnalysis]  
}

// MARK: - ColorAnalysis
struct ColorAnalysis: Decodable {
    let colorName: String
    let colorPercentage: Int
}

// MARK: - Label
struct Label: Codable {
    let name: String
    let confidence: Double
}
