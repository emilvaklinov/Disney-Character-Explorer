//
//  DetailItemView.swift
//  Disney Character Explorer
//
//  Created by Emil Vaklinov on 21/03/2024.
//

import SwiftUI

struct DetailItemView: View {
    @Environment(\.colorScheme) var colorScheme
    let label: String
    let content: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.headline)
            Text(content)
                .font(.body)
                .foregroundColor(colorScheme == .dark ? .white : .gray)
                .padding(.leading, 10)
        }
        .padding(10)
    }
}

#Preview {
    DetailItemView(label: "Label", content: "Content")
}
