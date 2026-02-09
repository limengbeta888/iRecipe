//
//  RecipeRow.swift
//  iRecipe
//
//  Created by Meng Li on 08/02/2026.
//

import SwiftUI
import NukeUI
import Nuke

struct RecipeCell: View {
    let recipe: Recipe
    private let imageSize = 64.0
    
    var body: some View {
        HStack(spacing: 12) {
            if let url = URL(string: recipe.image) {
                LazyImage(request: ImageRequest(url: url)) { state in
                    if let image = state.image {
                        image
                            .resizable()
                            .scaledToFill()
                    } else {
                        Color.gray.opacity(0.3)
                    }
                }
                .frame(width: imageSize, height: imageSize)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            } else {
                // Fallback if URL is invalid
                Color.gray.opacity(0.3)
                    .frame(width: imageSize, height: imageSize)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }

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
