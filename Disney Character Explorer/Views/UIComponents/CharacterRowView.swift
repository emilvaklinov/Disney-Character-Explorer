//
//  CharacterRowView.swift
//  Disney Character Explorer
//
//  Created by Emil Vaklinov on 20/03/2024.
//

import SwiftUI

struct CharacterRowView: View {
    var character: Character

    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            AsyncImage(url: URL(string: character.imageUrl ?? "")) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 170, height: 200)
            .overlay(Capsule().stroke(Color.gray, lineWidth: 2))
            .clipShape(Capsule())
            .scaledToFill()

            Text(character.name)
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .center)
                .tint(Color.black)
        }
    }
}

struct CharacterRowView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterRowView(character: Character(
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
