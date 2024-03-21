//
//  Character.swift
//  Disney Character Explorer
//
//  Created by Emil Vaklinov on 20/03/2024.
//

import Foundation

struct Character: Identifiable, Codable {
    var id: Int
    let films, tvShows, videoGames, parkAttractions: [String]
    let sourceURL: String?
    let name: String
    let imageUrl: String?
    let createdAt, updatedAt: String
    let url: String
    let v: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case films, tvShows, videoGames, parkAttractions, sourceURL = "sourceUrl", name, imageUrl
        case createdAt, updatedAt, url
        case v = "__v"
    }
}
