//
//  CharacterRepository.swift
//  Disney Character Explorer
//
//  Created by Emil Vaklinov on 20/03/2024.
//

import Foundation
import Combine

protocol CharacterRepositoryProtocol {
    func fetchCharacters() -> AnyPublisher<CharactersResponse, Error>
}

class CharacterRepository: CharacterRepositoryProtocol {
    private let networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }

    func fetchCharacters() -> AnyPublisher<CharactersResponse, Error> {
        let endpoint = Endpoint(path: "character")
        return networkService.request(endpoint: endpoint)
    }
}
