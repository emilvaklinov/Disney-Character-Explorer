//
//  CharacterListView.swift
//  Disney Character Explorer
//
//  Created by Emil Vaklinov on 20/03/2024.
//

import SwiftUI
import Combine

struct CharacterListView: View {
    @ObservedObject var viewModel: CharacterListViewModel
    @FocusState private var isSearchFocused: Bool
    @State private var searchText = ""
    
    var filteredCharacters: [Character] {
        if searchText.isEmpty {
            return viewModel.characters
        } else {
            return viewModel.characters.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
    
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
                
                HStack {
                    SearchBar(text: $searchText, placeholder: "Search Characters")
                        .listRowInsets(EdgeInsets())
                    
                    if !searchText.isEmpty {
                        Button(action: { searchText = "" }) {
                            Image(systemName: "xmark.circle.fill")
                                .padding()
                        }
                    }
                }
                
                List {
                    ForEach(filteredCharacters) { character in
                        NavigationLink(destination: CharacterDetailView(viewModel: CharacterDetailViewModel(character: character, favoritesManager: viewModel.favoritesManager))) {
                            CharacterRowView(character: character)
                        }
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .listStyle(PlainListStyle())
            }
            .navigationTitle("Characters")
            .onAppear {
                isSearchFocused = true
                searchText = ""
                viewModel.loadCharacters()
            }
        }
    }
}
