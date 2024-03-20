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
        VStack {
            Text(viewModel.character.name)
                .font(.title)
                .padding(20)
                .frame(maxWidth: .infinity, alignment: .center)
            
            AsyncImage(url: URL(string: viewModel.character.imageUrl ?? "")) { image in
                image.resizable()
            } placeholder: {
                Color.gray
            }
            .frame(width: 300, height: 350)
            .clipShape(RoundedRectangle(cornerRadius: 7))
            .scaledToFill()
            .padding()
            
            Spacer()
            
            Button(viewModel.isFavorite ? "Remove from Favorites" : "Add to Favorites") {
                viewModel.toggleFavoriteStatus()
            }
            .padding()
            .tint(Color.white)
            .background(Color.red)
            .cornerRadius(7)
            .font(.title2).bold()
        }.padding(.bottom, 20)
    }
}
