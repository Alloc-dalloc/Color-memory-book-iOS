//
//  WritingMemory.swift
//  ColorMemoryBook
//
//  Created by 김윤서 on 2023/06/11.
//

import Foundation

struct WritingMemory: Encodable {
    let imageUrl: String
    let tagList: [String]
    let description: String
}
