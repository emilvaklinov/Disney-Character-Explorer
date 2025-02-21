//
//  CharactersResponse.swift
//  Disney Character Explorer
//
//  Created by Emil Vaklinov on 20/03/2024.
//

import Foundation

struct CharactersResponse: Codable {
    let info: PageInfo
    let data: [Character]
}
