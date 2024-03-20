//
//  FavoritesManager.swift
//  Disney Character Explorer
//
//  Created by Emil Vaklinov on 20/03/2024.
//

import Foundation
import Combine

protocol FavoritesManagerProtocol {
    var favoritesPublisher: Published<Set<Int>>.Publisher { get }
    func addFavorite(characterId: Int)
    func removeFavorite(characterId: Int)
    func isFavorite(characterId: Int) -> Bool
    func getFavoriteCharacterIds() -> [Int]
}

class FavoritesManager: FavoritesManagerProtocol {
    
    private var defaults = UserDefaults.standard
    private let key = "FavoriteCharacters"
    @Published var favorites: Set<Int> = []
    static let shared = FavoritesManager()

    init(userDefaults: UserDefaults = .standard) {
        self.defaults = userDefaults
        loadFavorites()
    }

    private func loadFavorites() {
        let storedFavorites = defaults.array(forKey: key) as? [Int] ?? []
        favorites = Set(storedFavorites)
    }

    func addFavorite(characterId: Int) {
        favorites.insert(characterId)
        saveFavorites()
    }

    func removeFavorite(characterId: Int) {
        favorites.remove(characterId)
        saveFavorites()
    }

    func isFavorite(characterId: Int) -> Bool {
        favorites.contains(characterId)
    }

    func getFavoriteCharacterIds() -> [Int] {
        Array(favorites)
    }

    private func saveFavorites() {
        defaults.set(Array(favorites), forKey: key)
    }

    var favoritesPublisher: Published<Set<Int>>.Publisher { $favorites }
}

