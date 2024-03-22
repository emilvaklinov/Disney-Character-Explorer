//
//  MockFavoritesManager.swift
//  Disney Character ExplorerTests
//
//  Created by Emil Vaklinov on 22/03/2024.
//

import XCTest
import Combine
@testable import Disney_Character_Explorer

class MockFavoritesManager: FavoritesManagerProtocol {
    @Published private(set) var favorites: Set<Int> = []
    var favoritesPublisher: Published<Set<Int>>.Publisher { $favorites }

    init(initialFavorites: [Int] = []) {
        self.favorites = Set(initialFavorites)
    }

    func addFavorite(characterId: Int) {
        favorites.insert(characterId)
    }

    func removeFavorite(characterId: Int) {
        favorites.remove(characterId)
    }

    func isFavorite(characterId: Int) -> Bool {
        return favorites.contains(characterId)
    }

    func getFavoriteCharacterIds() -> [Int] {
        return Array(favorites)
    }
}
