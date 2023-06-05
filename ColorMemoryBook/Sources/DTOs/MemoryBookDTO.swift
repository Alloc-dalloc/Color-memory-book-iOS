//
//  MemoryBookDTO.swift
//  ColorMemoryBook
//
//  Created by 임영준 on 2023/06/02.
//

import Foundation

struct MemoryBookDTO : Decodable {
    let accessToken: String
    let refreshToken: String
}
