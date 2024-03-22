//
//  NetworkService.swift
//  Disney Character ExplorerTests
//
//  Created by Emil Vaklinov on 21/03/2024.
//

import Foundation
@testable import Disney_Character_Explorer
import Combine

import Combine

class MockNetworkService: NetworkServiceProtocol {
    var mockData: Data?
    var mockError: Error?

    func request<T: Decodable>(endpoint: Endpoint) -> AnyPublisher<T, Error> {
        if let error = mockError {
            // Return an error response
            return Fail(error: error).eraseToAnyPublisher()
        } else if let data = mockData {
            // Return the mocked data as a successful response
            return Just(data)
                .decode(type: T.self, decoder: JSONDecoder())
                .mapError { _ in NetworkError.decodingError }
                .eraseToAnyPublisher()
        } else {
            // If no mock data or error is set, return a default error
            return Fail(error: NetworkError.unknownError).eraseToAnyPublisher()
        }
    }

    func setupMockResponse<T: Encodable>(response: T) {
        do {
            let data = try JSONEncoder().encode(response)
            self.mockData = data
            self.mockError = nil
        } catch {
            self.mockData = nil
            self.mockError = NetworkError.decodingError
        }
    }

    func setupMockError(error: Error) {
        self.mockData = nil
        self.mockError = error
    }
}

enum NetworkError: Error {
    case invalidURL
    case httpError
    case decodingError
    case unknownError
}
