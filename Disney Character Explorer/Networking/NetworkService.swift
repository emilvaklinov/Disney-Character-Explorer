//
//  NetworkService.swift
//  Disney Character Explorer
//
//  Created by Emil Vaklinov on 20/03/2024.
//

import Foundation
import Combine

protocol NetworkServiceProtocol {
    func request<T: Decodable>(endpoint: Endpoint) -> AnyPublisher<T, Error>
}

class NetworkService: NetworkServiceProtocol {
    func request<T: Decodable>(endpoint: Endpoint) -> AnyPublisher<T, Error> {
        guard let url = endpoint.url else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .mapError { _ in NetworkError.httpError }
            .flatMap { data, response -> AnyPublisher<T, Error> in
                guard let httpResponse = response as? HTTPURLResponse,
                      200...299 ~= httpResponse.statusCode else {
                    return Fail(error: NetworkError.httpError).eraseToAnyPublisher()
                }
                return Just(data)
                    .decode(type: T.self, decoder: JSONDecoder())
                    .mapError { _ in NetworkError.decodingError }
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}

