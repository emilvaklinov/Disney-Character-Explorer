//
//  CharacterDetailSection.swift
//  Disney Character Explorer
//
//  Created by Emil Vaklinov on 21/03/2024.
//

import Foundation

struct CharacterDetailSection {
    let title: String
    let content: String
}

extension CharacterDetailViewModel {
    var detailSections: [CharacterDetailSection] {
        var sections: [CharacterDetailSection] = []

        if !character.films.isEmpty {
            sections.append(CharacterDetailSection(title: Constants.Titles.films, content: character.films.joined(separator: ", ")))
        }
        if !character.tvShows.isEmpty {
            sections.append(CharacterDetailSection(title: Constants.Titles.tvShows, content: character.tvShows.joined(separator: ", ")))
        }
        if !character.videoGames.isEmpty {
            sections.append(CharacterDetailSection(title: Constants.Titles.videoGames, content: character.videoGames.joined(separator: ", ")))
        }
        // Add other sections as needed

        return sections
    }
}
