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
    @Published private(set) var state: RecipeListState = .idle
    
    private let reducer = RecipeListReducer()
    private let recipeService: RecipeServiceProtocol

    private var isPreview: Bool = false
    
    init(container: Container = AppDelegate.container) {
        recipeService = container.resolve(RecipeServiceProtocol.self)!
    }

    convenience init(state: RecipeListState) {
        self.init()
        self.state = state
        self.isPreview = true
    }
    
    // MARK: - Intent
    func send(_ intent: RecipeListIntent) {
        guard !(isPreview && intent == .onAppear) else { return }

        switch intent {
        case .onAppear:
            guard case .idle = state else { return }
            loadRecipes()

        case .refresh, .retry:
            loadRecipes()
        }
    }

    // MARK: - Side Effect
    private func loadRecipes() {
        state = reducer.reduce(state: state, result: .loading)

        Task {
            do {
                let response = try await recipeService.fetchRecipes(limit: 20, skip: 0)
                state = reducer.reduce(
                    state: state,
                    result: .success(response.recipes)
                )
            } catch {
                state = reducer.reduce(
                    state: state,
                    result: .failure(error.localizedDescription)
                )
            }
        }
    }
}
