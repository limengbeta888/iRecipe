//
//  RecipeListStore.swift
//  iRecipe
//
//  Created by Meng Li on 08/02/2026.
//

import Combine
import SwiftUI
import Swinject

final class RecipeListStore: ObservableObject {
    @Published private(set) var state = RecipeListState()
    
    private let reducer = RecipeListReducer()
    private let recipeService: RecipeServiceProtocol

    private var isPreview: Bool = false
    private let limit = 20
    private var skip = 0
    
    init(container: Container = AppDelegate.container) {
        recipeService = container.resolve(RecipeServiceProtocol.self)!
    }

    // Only for Preview
    convenience init(state: RecipeListState) {
        self.init()
        self.state = state
        self.isPreview = true
    }
    
    // MARK: - Intent
    func send(_ intent: RecipeListIntent) {
        guard !(isPreview && intent == .onAppear) else { return }

        let newState = reducer.reduce(state: state, intent: intent)
        guard newState != state else { return }

        state = newState

        if state.isLoading || state.isLoadingMore {
            loadRecipes()
        }
    }

    // MARK: - Side Effect
    private func loadRecipes() {
        Task {
            do {
                let response = try await recipeService.fetchRecipes(limit: limit, skip: skip)

                skip += response.recipes.count

                state.isLoading = false
                state.isLoadingMore = false
                state.recipes.append(contentsOf: response.recipes)
                state.hasMore = !response.recipes.isEmpty

            } catch {
                state.isLoading = false
                state.isLoadingMore = false
                state.errorMessage = error.localizedDescription
            }
        }
    }
}
