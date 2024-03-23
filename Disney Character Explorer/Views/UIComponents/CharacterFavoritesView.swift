//
//  CharacterFavoritesView.swift
//  Disney Character Explorer
//
//  Created by Emil Vaklinov on 20/03/2024.
//

import SwiftUI

struct CharacterFavoritesView: View {
    @Environment(\.colorScheme) var colorScheme
    var character: Character

    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            AsyncImage(url: URL(string: character.imageUrl ?? "")) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 80, height: 80)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.orange, lineWidth: 2.5))

            Text(character.name.truncated(maxLength: 9))
                .font(.subheadline)
                .frame(maxWidth: .infinity, alignment: .center)
                .foregroundColor(colorScheme == .dark ? .white : .black)
        }
    }
}

struct CharacterFavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterFavoritesView(character: Character(
            id: 1,
            films: ["Movie 1", "Movie 2"],
            tvShows: ["TV Show 1"],
            videoGames: ["Game 1"],
            parkAttractions: ["Attraction 1"],
            sourceURL: "https://example.com",
            name: "Mickey Mouse",
            imageUrl: "https://static.wikia.nocookie.net/disney/images/d/d3/Vlcsnap-2015-05-06-23h04m15s601.png",
            createdAt: "2020-01-01",
            updatedAt: "2021-01-01",
            url: "https://example.com/mickey",
            v: 1)
        )
    }
}
