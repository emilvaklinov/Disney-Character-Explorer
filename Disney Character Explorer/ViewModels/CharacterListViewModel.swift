//
//  CharacterListViewModel.swift
//  Disney Character Explorer
//
//  Created by Emil Vaklinov on 20/03/2024.
//

import Foundation
import Combine

class CharacterListViewModel: ObservableObject {
    @Published var characters: [Character] = []
    @Published var favoriteCharacters: [Character] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var filteredCharacters: [Character] = []
    private var allCharacters: [Character] = []
    private var cancellables = Set<AnyCancellable>()
    private let repository: CharacterRepositoryProtocol
    let favoritesManager: FavoritesManager
    
    init(repository: CharacterRepositoryProtocol, favoritesManager: FavoritesManager = FavoritesManager.shared) {
        self.repository = repository
        self.favoritesManager = favoritesManager
        setupBindings()
        loadCharacters()
    }
    
    private func setupBindings() {
        // Subscribe to the favorites publisher
        favoritesManager.favoritesPublisher
            .sink { [weak self] _ in
                self?.updateFavoriteCharacters()
            }
            .store(in: &cancellables)
    }
    
    func loadCharacters() {
        isLoading = true
        errorMessage = nil
        
        repository.fetchCharacters()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    self?.isLoading = false
                    if case .failure(_) = completion {
                        self?.errorMessage = "Failed to load characters"
                    }
                },
                receiveValue: { [weak self] charactersResponse in
                    self?.characters = charactersResponse.data
                    self?.updateFavoriteCharacters()
                    self?.applyFilter()
                }
            )
            .store(in: &cancellables)
    }
    
    func applyFilter(with searchText: String = "") {
        if searchText.isEmpty {
            filteredCharacters = allCharacters
        } else {
            filteredCharacters = allCharacters.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }

    private func updateFavoriteCharacters() {
        let favoriteIds = Set(favoritesManager.getFavoriteCharacterIds())
        favoriteCharacters = characters.filter { favoriteIds.contains($0.id) }
    }
    
    func toggleFavorite(for character: Character) {
        if favoritesManager.isFavorite(characterId: character.id) {
            favoritesManager.removeFavorite(characterId: character.id)
        } else {
            favoritesManager.addFavorite(characterId: character.id)
        }
    }
}

extension Character: Equatable {
    static func ==(lhs: Character, rhs: Character) -> Bool {
        return lhs.id == rhs.id
    }
}

