//
//  RecipeDetailView.swift
//  iRecipe
//
//  Created by Meng Li on 08/02/2026.
//

import SwiftUI
import Combine

struct RecipeDetailView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var store: RecipeDetailStore
    let recipe: Recipe
    
    init(recipe: Recipe, store: RecipeDetailStore) {
        self.recipe = recipe
        self.store = store
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
            ToolbarItem(placement: .navigationBarLeading) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.black)
                    .onTapGesture {
                        dismiss()
                    }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    //viewModel.handle(.toggleFavorite)
                } label: {
//                    Image(systemName: viewModel.state.isFavorite ? "heart.fill" : "heart")
//                        .foregroundColor(viewModel.state.isFavorite ? .red : .primary)
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    //viewModel.handle(.shareRecipe)
                } label: {
                    Image(systemName: "square.and.arrow.up")
                }
            }
        }
        .onAppear {
//            store.send(.onAppear)
            setupSideEffectHandling()
        }
    }
    
    // MARK: - Side Effect Handling
    private func setupSideEffectHandling() {
//        viewModel.sideEffects
//            .sink { effect in
//                switch effect {
//                case .shareRecipe(let recipe):
//                    // Handle share action
//                    print("Share recipe: \(recipe.name)")
//                case .showFavoriteConfirmation:
//                    // Could show a toast or haptic feedback
//                    print("Favorite toggled")
//                }
//            }
//            .store(in: &cancellables)
    }
}



// MARK: - Preview
#Preview {
    let store = RecipeDetailStore()
    NavigationStack {
        RecipeDetailView(recipe: Recipe.mock, store: store)
    }
}
