//
//  CharacterListView.swift
//  Disney Character Explorer
//
//  Created by Emil Vaklinov on 20/03/2024.
//

import SwiftUI

struct CharacterListView: View {
    @ObservedObject var viewModel: CharacterListViewModel
    
    let favoritesManager = FavoritesManager()
    
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    var body: some View {
        NavigationView {
            VStack {
                if !viewModel.favoriteCharacters.isEmpty {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(viewModel.favoriteCharacters) { character in
                                NavigationLink(destination: CharacterDetailView(viewModel: CharacterDetailViewModel(character: character, favoritesManager: viewModel.favoritesManager))) {
                                    CharacterFavoritesView(character: character)
                                }
                            }
                        }
                        .padding(15)
                    }
                    .frame(height: 130)
                }
                
                List {
                    ForEach(viewModel.characters) { character in
                        NavigationLink(destination: CharacterDetailView(viewModel: CharacterDetailViewModel(character: character, favoritesManager: viewModel.favoritesManager))) {
                            CharacterRowView(character: character)
                        }
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                
            }
            .navigationTitle("Characters")
            .onAppear {
                DispatchQueue.main.async {
                    viewModel.loadCharacters()
                }
            }
        }
    }
}
