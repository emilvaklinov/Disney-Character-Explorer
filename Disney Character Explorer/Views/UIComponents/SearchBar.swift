//
//  SearchBar.swift
//  Disney Character Explorer
//
//  Created by Emil Vaklinov on 21/03/2024.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    var placeholder: String

    var body: some View {
        HStack {
            TextField(placeholder, text: $text)
                .padding(7)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal)
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        // Simulating a binding using .constant
        SearchBar(text: .constant(""), placeholder: "Search Characters")
    }
}
