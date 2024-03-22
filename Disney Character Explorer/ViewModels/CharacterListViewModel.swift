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
    @Published var selectedFilter: CharacterFilterOption = .all
    @Published var searchText: String = ""
    private var allCharacters: [Character] = []
    private var cancellables = Set<AnyCancellable>()
    private let repository: CharacterRepositoryProtocol
    let favoritesManager: FavoritesManagerProtocol
    
    init(repository: CharacterRepositoryProtocol, favoritesManager: FavoritesManagerProtocol) {
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
                    self?.allCharacters = charactersResponse.data
                    self?.applyCategoryFilter()
                    self?.updateFavoriteCharacters()
                }
            )
            .store(in: &cancellables)
    }

    func applyFilter(with searchText: String = "") {
        self.searchText = searchText
        applyCategoryFilter()
    }
    
    func applyCategoryFilter() {
        if selectedFilter == .all {
            filteredCharacters = searchText.isEmpty ? allCharacters : allCharacters.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        } else {
            let filterStrategy = getFilteringStrategy(for: selectedFilter)
            filteredCharacters = filterStrategy.filter(characters: allCharacters, basedOn: selectedFilter, with: searchText)
        }
    }

    private func getFilteringStrategy(for filter: CharacterFilterOption) -> CharacterFiltering {
        switch filter {
        case .all: return AllCharactersFilter()
        case .films: return FilmsFilter()
        case .tvShows: return TVShowsFilter()
        case .videoGames: return VideoGamesFilter()
        case .parkAttractions: return ParkAttractionsFilter()
        }
    }

    private func updateFavoriteCharacters() {
        let favoriteIds = Set(favoritesManager.getFavoriteCharacterIds())
        favoriteCharacters = allCharacters.filter { favoriteIds.contains($0.id) }
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

