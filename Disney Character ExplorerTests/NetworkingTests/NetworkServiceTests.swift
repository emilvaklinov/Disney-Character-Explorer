//
//  MockURLSession.swift
//  Disney Character ExplorerTests
//
//  Created by Emil Vaklinov on 21/03/2024.
//

import XCTest
@testable import Disney_Character_Explorer
import Combine

class NetworkServiceTests: XCTestCase {
    var repository: CharacterRepository!
    var mockNetworkService: MockNetworkService!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        repository = CharacterRepository(networkService: mockNetworkService)
        cancellables = []
    }

    override func tearDown() {
        repository = nil
        mockNetworkService = nil
        cancellables = nil
        super.tearDown()
    }

    func testFetchCharactersSuccess() {
        guard let mockCharactersResponse = loadMockCharactersResponse() else {
            XCTFail("Failed to load mock characters response")
            return
        }

        mockNetworkService.setupMockResponse(response: mockCharactersResponse)

        let expectation = XCTestExpectation(description: "Fetch characters success")

        // Perform the fetch request and handle the result
        repository.fetchCharacters()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Request should not fail, but failed with error: \(error)")
                }
            }, receiveValue: { response in
                // Assertions to validate the response
                XCTAssertEqual(response.data.count, mockCharactersResponse.data.count, "Response data count should match mock data count")
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 5.0)
    }
    
    func testFetchCharactersFailure() {
        mockNetworkService.mockError = NetworkError.httpError

        let expectation = XCTestExpectation(description: "Fetch characters failure")
        repository.fetchCharacters()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion, case .httpError = error as? NetworkError {
                    expectation.fulfill()
                }
            }, receiveValue: { _ in })
            .store(in: &cancellables)
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testDecodingFailure() {
        mockNetworkService.mockData = Data("Invalid JSON".utf8)

        let expectation = XCTestExpectation(description: "Decoding error")
        repository.fetchCharacters()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion, case .decodingError = error as? NetworkError {
                    expectation.fulfill()
                }
            }, receiveValue: { _ in })
            .store(in: &cancellables)
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testInvalidURL() {
        // Simulate an invalid URL error
        mockNetworkService.setupMockError(error: NetworkError.invalidURL)

        let expectation = XCTestExpectation(description: "Invalid URL error")
        repository.fetchCharacters()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion, case NetworkError.invalidURL = error {
                    expectation.fulfill()
                }
            }, receiveValue: { _ in })
            .store(in: &cancellables)
        wait(for: [expectation], timeout: 5.0)
    }

    func testHTTPStatusCodeError() {
        // Simulate a 500 HTTP status code error
        mockNetworkService.setupMockError(error: NetworkError.httpError)

        let expectation = XCTestExpectation(description: "HTTP status code error")
        repository.fetchCharacters()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion, case NetworkError.httpError = error {
                    expectation.fulfill()
                }
            }, receiveValue: { _ in })
            .store(in: &cancellables)
        wait(for: [expectation], timeout: 5.0)
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


