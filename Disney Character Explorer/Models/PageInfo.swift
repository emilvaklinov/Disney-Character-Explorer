//
//  PageInfo.swift
//  Disney Character Explorer
//
//  Created by Emil Vaklinov on 20/03/2024.
//

import Foundation

struct PageInfo: Codable {
    let count: Int
    let totalPages: Int
    let previousPage: String?
    let nextPage: String?
}
