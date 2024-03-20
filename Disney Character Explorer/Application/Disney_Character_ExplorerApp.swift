//
//  Disney_Character_ExplorerApp.swift
//  Disney Character Explorer
//
//  Created by Emil Vaklinov on 20/03/2024.
//

import SwiftUI

@main
struct Disney_Character_ExplorerApp: App {
    var body: some Scene {
        WindowGroup {
            let repository = CharacterRepository(networkService: NetworkService())
            let viewModel = CharacterListViewModel(repository: repository)
            CharacterListView(viewModel: viewModel)
        }
    }
}
