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

    var shareButton: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button {
                store.send(.share)
            } label: {
                Image(systemName: "square.and.arrow.up")
            }
        }
    }
}

// MARK: - Preview

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PreviewWrapper()
                .previewDisplayName("English")
                .environment(\.locale, Locale(identifier: "en"))
            
            PreviewWrapper()
                .previewDisplayName("Chinese")
                .environment(\.locale, Locale(identifier: "zh-Hans"))
        }
    }
    
    private struct PreviewWrapper: View {
        var body: some View {
            NavigationStack {
                RecipeDetailView(
                    store: RecipeDetailStore(recipe: Recipe.mock),
                    recipe: Recipe.mock
                )
            }
        }
    }
}
