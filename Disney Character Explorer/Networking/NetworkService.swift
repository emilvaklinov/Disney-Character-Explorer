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
            print("Invalid URL")
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        print("URL: \(url.absoluteString)")
        return URLSession.shared.dataTaskPublisher(for: url)
            .mapError { error in
                print("Networking error: \(error)")
                return NetworkError.httpError
            }
            .flatMap { data, response -> AnyPublisher<T, Error> in
                guard let httpResponse = response as? HTTPURLResponse else {
                    print("Invalid HTTP response")
                    return Fail(error: NetworkError.httpError).eraseToAnyPublisher()
                }
                print("HTTP Status Code: \(httpResponse.statusCode)")
                guard 200...299 ~= httpResponse.statusCode else {
                    return Fail(error: NetworkError.httpError).eraseToAnyPublisher()
                }
                return Just(data)
                    .decode(type: T.self, decoder: JSONDecoder())
                    .mapError { error in
                        print("Decoding error: \(error)")
                        return NetworkError.decodingError
                    }
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}

