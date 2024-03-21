//
//  CharacterDetailViewModel.swift
//  Disney Character Explorer
//
//  Created by Emil Vaklinov on 20/03/2024.
//

import SwiftUI

struct CharacterDetailView: View {
    @ObservedObject var viewModel: CharacterDetailViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                Text(viewModel.character.name)
                    .font(.title)
                    .padding([.leading, .bottom])
                    .frame(maxWidth: .infinity, alignment: .center)
                
                AsyncImage(url: URL(string: viewModel.character.imageUrl ?? "")) { image in
                    image.resizable()
                } placeholder: {
                    Color.gray
                }
                .frame(width: 300, height: 350)
                .clipShape(RoundedRectangle(cornerRadius: 7))
                .padding([.leading, .bottom])
                
                HStack (alignment: .center, spacing: 15) {
                    Text("\(Constants.Emojis.films): \(viewModel.character.films.count)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                          Text("\(Constants.Emojis.videoGames): \(viewModel.character.videoGames.count)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text("\(Constants.Emojis.tvShows): \(viewModel.character.tvShows.count)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                VStack (alignment: .leading, spacing: 5) {
                    ForEach(viewModel.detailSections, id: \.title) { section in
                        DetailItemView(label: section.title, content: section.content)
                    }
                }
                .padding()
                
                if let sourceURL = viewModel.character.sourceURL, let url = URL(string: sourceURL) {
                    Link(Constants.Links.visitWiki, destination: url)
                        .padding(.bottom)
                        .bold()
                }
            }
        }
        Button(viewModel.isFavorite ? Constants.Buttons.removeFromFavorites : Constants.Buttons.addToFavorites) {
            viewModel.toggleFavoriteStatus()
        }
        .padding()
        .foregroundColor(.white)
        .background(viewModel.isFavorite ? Color.red : Color.blue)
        .cornerRadius(7)
        .font(.title2)
        .padding(.horizontal)
        
    }
}

