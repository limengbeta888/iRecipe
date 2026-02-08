//
//  RecipeDetailStore.swift
//  iRecipe
//
//  Created by Meng Li on 08/02/2026.
//

import Combine
import SwiftUI

final class RecipeDetailStore: ObservableObject {
    @Published private(set) var state: RecipeDetailState

    private let reducer = RecipeDetailReducer()
    private let recipe: Recipe

    let effects = PassthroughSubject<RecipeDetailEffect, Never>()

    init(recipe: Recipe, isFavorite: Bool = false) {
        self.recipe = recipe
        self.state = .idle(isFavorite: isFavorite)
    }

    // MARK: - Intent
    func send(_ intent: RecipeDetailIntent) {
        let (newState, effect) = reducer.reduce(state: state, intent: intent)
        state = newState

        if let effect {
            handle(effect)
        }
    }
    
    // MARK: - Side Effect
    private func handle(_ effect: RecipeDetailEffect) {
        switch effect {
        case .shareRecipe:
            effects.send(.shareRecipe)
        }
    }
}
