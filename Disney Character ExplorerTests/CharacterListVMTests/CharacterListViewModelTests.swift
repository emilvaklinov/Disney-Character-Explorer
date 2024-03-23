//
//  CharacterListViewModelTests.swift
//  Disney Character ExplorerTests
//
//  Created by Emil Vaklinov on 22/03/2024.
//

import XCTest
import Combine
@testable import Disney_Character_Explorer

class CharacterListViewModelTests: XCTestCase {
    private var viewModel: CharacterListViewModel!
    private var mockRepository: MockCharacterRepository!
    private var mockFavoritesManager: MockFavoritesManager!
    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockRepository = MockCharacterRepository()
        mockFavoritesManager = MockFavoritesManager()
        viewModel = CharacterListViewModel(repository: mockRepository, favoritesManager: mockFavoritesManager)
        cancellables = []
    }

    override func tearDown() {
        viewModel = nil
        mockRepository = nil
        mockFavoritesManager = nil
        cancellables = nil
        super.tearDown()
    }

    func testLoadCharactersSuccess() {
        guard let mockCharactersResponse = loadMockCharactersResponse() else {
            XCTFail("Failed to load mock characters response")
            return
        }

        mockRepository.mockCharactersResponse = Just(mockCharactersResponse)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()

        let expectation = XCTestExpectation(description: "Characters load successfully")

        // Subscribe to the characters published by the view model
        viewModel.$characters
            .dropFirst()  // Ignore the initial empty array
            .sink { characters in
                XCTAssertEqual(characters, mockCharactersResponse.data, "Loaded characters should match the mock data")
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.loadCharacters()

        wait(for: [expectation], timeout: 2.0)
    }
    
    func testApplyAllFilter() {
        guard let mockCharactersResponse = loadMockCharactersResponse() else {
            XCTFail("Failed to load mock characters response")
            return
        }
        viewModel.characters = mockCharactersResponse.data
        viewModel.allCharacters = mockCharactersResponse.data

        // Apply 'All' filter
        viewModel.applyCategoryFilter()

        // Check if all characters are included
        XCTAssertEqual(viewModel.filteredCharacters.count, 3, "All characters should be included for 'All' filter")
    }
    
    func testApplyFilmsFilter() {
        guard let mockCharactersResponse = loadMockCharactersResponse() else {
            XCTFail("Failed to load mock characters response")
            return
        }
        viewModel.allCharacters = mockCharactersResponse.data
        viewModel.selectedFilter = .films

        // Act
        viewModel.applyCategoryFilter()

        // Assert
        let expectedFilmsFilteredCount = mockCharactersResponse.data.filter { !$0.films.isEmpty }.count
        XCTAssertEqual(viewModel.filteredCharacters.count, expectedFilmsFilteredCount, "Filtered count should match the number of characters with films")
    }

    func testApplyTVShowsFilter() {
        guard let mockCharactersResponse = loadMockCharactersResponse() else {
            XCTFail("Failed to load mock characters response")
            return
        }
        viewModel.allCharacters = mockCharactersResponse.data
        viewModel.selectedFilter = .tvShows

        // Act
        viewModel.applyCategoryFilter()

        // Assert
        let expectedFilmsFilteredCount = mockCharactersResponse.data.filter { !$0.tvShows.isEmpty }.count
        XCTAssertEqual(viewModel.filteredCharacters.count, expectedFilmsFilteredCount, "Filtered count should match the number of characters with tv shows")
    }
    
    func testApplyVideoGamesFilter() {
        guard let mockCharactersResponse = loadMockCharactersResponse() else {
            XCTFail("Failed to load mock characters response")
            return
        }
        viewModel.allCharacters = mockCharactersResponse.data
        viewModel.selectedFilter = .videoGames

        // Act
        viewModel.applyCategoryFilter()

        // Assert
        let expectedFilmsFilteredCount = mockCharactersResponse.data.filter { !$0.videoGames.isEmpty }.count
        XCTAssertEqual(viewModel.filteredCharacters.count, expectedFilmsFilteredCount, "Filtered count should match the number of characters with video games")
    }
    
    func testApplyParkAttractionsFilter() {
        guard let mockCharactersResponse = loadMockCharactersResponse() else {
            XCTFail("Failed to load mock characters response")
            return
        }
        viewModel.allCharacters = mockCharactersResponse.data
        viewModel.selectedFilter = .parkAttractions

        // Act
        viewModel.applyCategoryFilter()

        // Assert
        let expectedFilmsFilteredCount = mockCharactersResponse.data.filter { !$0.parkAttractions.isEmpty }.count
        XCTAssertEqual(viewModel.filteredCharacters.count, expectedFilmsFilteredCount, "Filtered count should match the number of characters with video games")
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
