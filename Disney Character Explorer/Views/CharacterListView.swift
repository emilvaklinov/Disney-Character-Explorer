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
                    SearchBar(text: $searchText, placeholder: Constants.Placeholders.searchCharacters)
                        .listRowInsets(EdgeInsets())
                    if !searchText.isEmpty {
                        Button(action: { searchText = "" }) {
                            Image(systemName: "xmark.circle.fill").font(.title2)
                        }
                    }
                    FilterButton(selectedFilter: $viewModel.selectedFilter)
                }
                .onChange(of: searchText) { newValue in
                    viewModel.applyFilter(with: newValue)
                }
                .padding(.trailing, 20)
                
                List {
                    ForEach(viewModel.filteredCharacters) { character in
                        NavigationLink(destination: CharacterDetailView(viewModel: CharacterDetailViewModel(character: character, favoritesManager: viewModel.favoritesManager))) {
                            CharacterRowView(character: character)
                        }
                    }
                }
                .onChange(of: viewModel.selectedFilter) { _ in
                    viewModel.applyCategoryFilter()
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .listStyle(PlainListStyle())
            }
            .navigationTitle(Constants.Titles.characters)
            .onAppear {
                isSearchFocused = true
                searchText = ""
                viewModel.loadCharacters()
            }
            .onChange(of: viewModel.selectedFilter) { _ in
                viewModel.applyCategoryFilter()
            }
        }
    }
}
