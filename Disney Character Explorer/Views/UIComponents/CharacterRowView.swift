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
            .frame(width: 150, height: 180)
            .overlay(RoundedRectangle(cornerRadius: 7).stroke(Color.gray, lineWidth: 2))
            .clipShape(RoundedRectangle(cornerRadius: 7))
            .scaledToFill()
            VStack {
                Text(character.name)
                    .font(.title2)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .tint(Color.black)
                    .padding()
                VStack (alignment: .center , spacing: 10) {
                    HStack (alignment: .center , spacing: 5) {
                        Text("\(Constants.Emojis.films): \(character.films.count)")
                            .font(.subheadline)
                            .foregroundColor(.orange).bold()
                        Text("\(Constants.Emojis.videoGames): \(character.videoGames.count)")
                            .font(.subheadline)
                            .foregroundColor(.black).bold()
                    }
                    Divider()
                    HStack (alignment: .firstTextBaseline , spacing: 5) {
                        Text("\(Constants.Emojis.tvShows): \(character.tvShows.count)")
                            .font(.subheadline)
                            .foregroundColor(.red).bold()
                        Text("\(Constants.Emojis.parkEmoji): \(character.parkAttractions.count)")
                            .font(.subheadline)
                            .foregroundColor(.green).bold()
                    }
                    .padding(.horizontal)
                }
            }
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
