//
//  MockCharacterRepository.swift
//  Disney Character ExplorerTests
//
//  Created by Emil Vaklinov on 22/03/2024.
//

import XCTest
import Combine
@testable import Disney_Character_Explorer

class MockCharacterRepository: CharacterRepositoryProtocol {
    var mockCharactersResponse: AnyPublisher<CharactersResponse, Error>?

    func fetchCharacters() -> AnyPublisher<CharactersResponse, Error> {
        return mockCharactersResponse ?? Fail(error: NSError(domain: "", code: -1, userInfo: nil)).eraseToAnyPublisher()
    }
}
