//
//  CharacterFilteringTests.swift
//  Disney Character ExplorerTests
//
//  Created by Emil Vaklinov on 23/03/2024.
//

import XCTest
@testable import Disney_Character_Explorer

class CharacterFilteringTests: XCTestCase {

    var allCharactersFilter: AllCharactersFilter!
    var filmsFilter: FilmsFilter!
    var tvShowsFilter: TVShowsFilter!
    var videoGamesFilter: VideoGamesFilter!
    var parkAttractionsFilter: ParkAttractionsFilter!
    var mockCharacters: [Character]!

    override func setUp() {
        super.setUp()
        allCharactersFilter = AllCharactersFilter()
        filmsFilter = FilmsFilter()
        tvShowsFilter = TVShowsFilter()
        videoGamesFilter = VideoGamesFilter()
        parkAttractionsFilter = ParkAttractionsFilter()
        mockCharacters = loadMockCharactersResponse()?.data ?? []
    }

    override func tearDown() {
        allCharactersFilter = nil
        filmsFilter = nil
        tvShowsFilter = nil
        videoGamesFilter = nil
        parkAttractionsFilter = nil
        mockCharacters = nil
        super.tearDown()
    }

    func testAllCharactersFilter() {
        let filteredCharacters = allCharactersFilter.filter(characters: mockCharacters, basedOn: .all, with: "")
        XCTAssertEqual(filteredCharacters.count, mockCharacters.count)
    }

    func testFilmsFilter() {
        let filteredCharacters = filmsFilter.filter(characters: mockCharacters, basedOn: .films, with: "")
        let expectedCount = mockCharacters.filter { !$0.films.isEmpty }.count
        XCTAssertEqual(filteredCharacters.count, expectedCount)
    }

    func testTVShowsFilter() {
        let filteredCharacters = tvShowsFilter.filter(characters: mockCharacters, basedOn: .tvShows, with: "")
        let expectedCount = mockCharacters.filter { !$0.tvShows.isEmpty }.count
        XCTAssertEqual(filteredCharacters.count, expectedCount)
    }

    func testVideoGamesFilter() {
        let filteredCharacters = videoGamesFilter.filter(characters: mockCharacters, basedOn: .videoGames, with: "")
        let expectedCount = mockCharacters.filter { !$0.videoGames.isEmpty }.count
        XCTAssertEqual(filteredCharacters.count, expectedCount)
    }

    func testParkAttractionsFilter() {
        let filteredCharacters = parkAttractionsFilter.filter(characters: mockCharacters, basedOn: .parkAttractions, with: "")
        let expectedCount = mockCharacters.filter { !$0.parkAttractions.isEmpty }.count
        XCTAssertEqual(filteredCharacters.count, expectedCount)
    }

    private func loadMockCharactersResponse() -> CharactersResponse? {
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


