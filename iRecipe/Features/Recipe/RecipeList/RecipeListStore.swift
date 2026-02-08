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
    
    func send(_ intent: RecipeListIntent) {
        guard !(isPreview && intent == .onAppear) else { return }
        
        state = reducer.reduce(state: state, intent: intent)
        
        if case .loading = state {
            loadRecipe()
        }
    }

    private func loadRecipe() {
//        Task {
//            do {
//                let recipe = try await recipeService.fetchRecipe()
//                state = reducer.reduce(
//                    state: state,
//                    intent: .loadSuccess(recipe)
//                )
//            } catch {
//                state = reducer.reduce(
//                    state: state,
//                    intent: .loadFailure(error)
//                )
//            }
//        }
    }
}
