//
//  CharacterDetailViewModel.swift
//  Disney Character Explorer
//
//  Created by Emil Vaklinov on 20/03/2024.
//

import Combine
import Foundation

class CharacterDetailViewModel: ObservableObject {
    @Published var character: Character
    @Published var isFavorite: Bool
    private var favoritesManager: FavoritesManager
    private var cancellables = Set<AnyCancellable>()

    init(character: Character, favoritesManager: FavoritesManager) {
        self.character = character
        self.favoritesManager = favoritesManager
        self.isFavorite = favoritesManager.isFavorite(characterId: character.id)

        favoritesManager.$favorites
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.isFavorite = favoritesManager.isFavorite(characterId: character.id)
            }
            .store(in: &cancellables)
    }

    func toggleFavoriteStatus() {
        if isFavorite {
            favoritesManager.removeFavorite(characterId: character.id)
        } else {
            favoritesManager.addFavorite(characterId: character.id)
        }
        isFavorite.toggle()
    }
}
