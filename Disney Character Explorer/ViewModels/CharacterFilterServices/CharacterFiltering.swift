//
//  CharacterFilterService.swift
//  Disney Character Explorer
//
//  Created by Emil Vaklinov on 22/03/2024.
//

import Foundation

protocol CharacterFiltering {
    func filter(characters: [Character], basedOn filter: CharacterFilterOption, with searchText: String) -> [Character]
}

struct AllCharactersFilter: CharacterFiltering {
    func filter(characters: [Character], basedOn filter: CharacterFilterOption, with searchText: String) -> [Character] {
        return characters.filter {
            searchText.isEmpty || $0.name.lowercased().contains(searchText.lowercased())
        }
    }
}

struct FilmsFilter: CharacterFiltering {
    func filter(characters: [Character], basedOn filter: CharacterFilterOption, with searchText: String) -> [Character] {
        characters.filter { !$0.films.isEmpty && (searchText.isEmpty || $0.name.lowercased().contains(searchText.lowercased())) }
                  .sorted { $0.films.count > $1.films.count }
    }
}

struct TVShowsFilter: CharacterFiltering {
    func filter(characters: [Character], basedOn filter: CharacterFilterOption, with searchText: String) -> [Character] {
        characters.filter { !$0.tvShows.isEmpty && (searchText.isEmpty || $0.name.lowercased().contains(searchText.lowercased())) }
                  .sorted { $0.tvShows.count > $1.tvShows.count }
    }
}

struct VideoGamesFilter: CharacterFiltering {
    func filter(characters: [Character], basedOn filter: CharacterFilterOption, with searchText: String) -> [Character] {
        characters.filter { !$0.videoGames.isEmpty && (searchText.isEmpty || $0.name.lowercased().contains(searchText.lowercased())) }
                  .sorted { $0.videoGames.count > $1.videoGames.count }
    }
}

struct ParkAttractionsFilter: CharacterFiltering {
    func filter(characters: [Character], basedOn filter: CharacterFilterOption, with searchText: String) -> [Character] {
        characters.filter { !$0.parkAttractions.isEmpty && (searchText.isEmpty || $0.name.lowercased().contains(searchText.lowercased())) }
                  .sorted { $0.parkAttractions.count > $1.parkAttractions.count }
    }
}
