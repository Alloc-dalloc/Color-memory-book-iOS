//
//  MemoryList.swift
//  ColorMemoryBook
//
//  Created by 임영준 on 2023/06/03.
//

import Foundation

struct MemoryImage: Codable {
    let id: Int
    let imageURL: String
}

typealias MemoryList = [MemoryImage]
