//
//  RecipeRow.swift
//  iRecipe
//
//  Created by Meng Li on 08/02/2026.
//

import SwiftUI

struct RecipeCell: View {
    let recipe: Recipe

    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: URL(string: recipe.image)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Color.gray.opacity(0.3)
            }
            .frame(width: 64, height: 64)
            .clipShape(RoundedRectangle(cornerRadius: 8))

            VStack(alignment: .leading, spacing: 4) {
                Text(recipe.name)
                    .font(.headline)

                Text("\(recipe.cuisine) • \(recipe.difficulty)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                Text("⭐️ \(recipe.formattedRating)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    RecipeCell(recipe: Recipe.mock)
}
