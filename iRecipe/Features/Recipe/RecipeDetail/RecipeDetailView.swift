//
//  RecipeDetailView.swift
//  iRecipe
//
//  Created by Meng Li on 08/02/2026.
//

import SwiftUI
import Combine

struct RecipeDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var store: RecipeDetailStore

    @State private var shareItems: [Any] = []
    @State private var showShareSheet = false
    
    let recipe: Recipe

    init(store: RecipeDetailStore, recipe: Recipe) {
        self.store = store
        self.recipe = recipe
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                RecipeTitleCardView(recipe: recipe)
                RecipeInfoView(recipe: recipe)
                RecipeIngredientsView(recipe: recipe)
                RecipeInstructionsView(recipe: recipe)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            favoriteButton
            shareButton
        }
        .onReceive(store.effects) { effect in
            switch effect {
            case .shareRecipe:
                shareItems = [
                    recipe.name,
                    recipe.image,
                    "Cuisine: \(recipe.cuisine)",
                    "Rating: ⭐️ \(recipe.formattedRating)"
                ]
                showShareSheet = true
            }
        }
        .sheet(isPresented: $showShareSheet) {
            ShareSheet(items: shareItems)
        }
    }
    
    var favoriteButton: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button {
                store.send(.toggleFavorite)
            } label: {
                Image(systemName: isFavorite ? "heart.fill" : "heart")
                    .foregroundColor(isFavorite ? .red : .primary)
            }
        }
    }

    var shareButton: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button {
                store.send(.share)
            } label: {
                Image(systemName: "square.and.arrow.up")
            }
        }
    }

    var isFavorite: Bool {
        if case .idle(let value) = store.state {
            return value
        }
        return false
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        RecipeDetailView(
            store: RecipeDetailStore(
                recipe: Recipe.mock,
                isFavorite: true
            ),
            recipe: Recipe.mock
        )
    }
}
