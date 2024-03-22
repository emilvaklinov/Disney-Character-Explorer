//
//  FilterButtonView.swift
//  Disney Character Explorer
//
//  Created by Emil Vaklinov on 22/03/2024.
//

import SwiftUI

struct FilterButton: View {
    @Binding var selectedFilter: CharacterFilterOption

    var body: some View {
        Menu {
            ForEach(CharacterFilterOption.allCases, id: \.self) { option in
                Button(option.rawValue) {
                    selectedFilter = option
                }
            }
        } label: {
            Image(systemName: "line.horizontal.3.decrease.circle")
                .font(.title2)
        }
    }
}
