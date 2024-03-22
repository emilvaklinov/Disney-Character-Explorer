//
//  FavoritesManagerTests.swift
//  Disney Character ExplorerTests
//
//  Created by Emil Vaklinov on 22/03/2024.
//

import XCTest
@testable import Disney_Character_Explorer

class FavoritesManagerTests: XCTestCase {
    var favoritesManager: FavoritesManager!
    var mockUserDefaults: MockUserDefaults!

    override func setUp() {
        super.setUp()
        mockUserDefaults = MockUserDefaults()
        favoritesManager = FavoritesManager(userDefaults: mockUserDefaults)
    }

    override func tearDown() {
        favoritesManager = nil
        mockUserDefaults = nil
        super.tearDown()
    }
    
    func testAddFavorite() {
        let characterId = 1
        favoritesManager.addFavorite(characterId: characterId)
        XCTAssertTrue(favoritesManager.isFavorite(characterId: characterId), "Character should be favorite after adding")
    }

    func testRemoveFavorite() {
        let characterId = 1
        favoritesManager.addFavorite(characterId: characterId)
        favoritesManager.removeFavorite(characterId: characterId)
        XCTAssertFalse(favoritesManager.isFavorite(characterId: characterId), "Character should not be favorite after removing")
    }

    func testIsFavorite() {
        let characterId = 1
        favoritesManager.addFavorite(characterId: characterId)
        XCTAssertTrue(favoritesManager.isFavorite(characterId: characterId), "isFavorite should return true for a favorited character")
    }

    func testGetFavoriteCharacterIds() {
        let characterIds = [1, 2, 3]
        characterIds.forEach { favoritesManager.addFavorite(characterId: $0) }
        let sortedFavoritedIds = favoritesManager.getFavoriteCharacterIds().sorted()
        let sortedCharacterIds = characterIds.sorted()
        XCTAssertEqual(sortedFavoritedIds, sortedCharacterIds, "getFavoriteCharacterIds should return all favorited character IDs in sorted order")
    }

    func testSavingFavorites() {
        let characterId = 1
        favoritesManager.addFavorite(characterId: characterId)

        let savedFavorites = mockUserDefaults.array(forKey: "FavoriteCharacters") as? [Int]
        XCTAssertEqual(savedFavorites, [characterId], "Favorites should be saved to UserDefaults")
    }

    func testLoadingFavorites() {
        let characterIds = [1, 2]
        mockUserDefaults.set(characterIds, forKey: "FavoriteCharacters")
        favoritesManager = FavoritesManager(userDefaults: mockUserDefaults)

        XCTAssertTrue(characterIds.allSatisfy { favoritesManager.isFavorite(characterId: $0) }, "FavoritesManager should load favorites from UserDefaults")
    }
}
