//
//  CharacterDetailViewModelTests.swift
//  Disney Character ExplorerTests
//
//  Created by Emil Vaklinov on 22/03/2024.
//

@testable import Disney_Character_Explorer
import XCTest
import Combine

class CharacterDetailViewModelTests: XCTestCase {
    var viewModel: CharacterDetailViewModel!
    private var mockRepository: MockCharacterRepository!
    var mockFavoritesManager: MockFavoritesManager!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockFavoritesManager = MockFavoritesManager()
        mockRepository = MockCharacterRepository()

        guard let testCharacter = loadMockCharactersResponse()?.data.first else {
            XCTFail("Failed to load a test character")
            return
        }
        
        viewModel = CharacterDetailViewModel(character: testCharacter, favoritesManager: mockFavoritesManager)
        cancellables = []
    }

    override func tearDown() {
        viewModel = nil
        mockFavoritesManager = nil
        cancellables = nil
        super.tearDown()
    }

    func testInitialState() {
        // Verify initial state of isFavorite
        let expectedFavoriteState = mockFavoritesManager.isFavorite(characterId: viewModel.character.id)
        XCTAssertEqual(viewModel.isFavorite, expectedFavoriteState, "Initial isFavorite state should match the favorites manager state")
    }

    func testToggleFavoriteStatus() {
        let initialFavoriteState = viewModel.isFavorite
        viewModel.toggleFavoriteStatus()

        // Verify isFavorite is toggled
        XCTAssertEqual(viewModel.isFavorite, !initialFavoriteState, "isFavorite should be toggled after calling toggleFavoriteStatus")

        // Verify favorites manager is updated correctly
        let shouldBeFavorite = mockFavoritesManager.isFavorite(characterId: viewModel.character.id)
        XCTAssertEqual(viewModel.isFavorite, shouldBeFavorite, "Favorites manager should reflect the new favorite status")
    }

    func loadMockCharactersResponse() -> CharactersResponse? {
        guard let url = Bundle(for: type(of: self)).url(forResource: "MockJSONData", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            XCTFail("Failed to load mock characters response")
            return nil
        }

        do {
            let charactersResponse = try JSONDecoder().decode(CharactersResponse.self, from: data)
            return charactersResponse
        } catch {
            XCTFail("Error decoding mock data: \(error)")
            return nil
        }
    }
}
