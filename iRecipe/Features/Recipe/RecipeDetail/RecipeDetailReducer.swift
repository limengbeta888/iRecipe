//
//  RecipeDetailReducer.swift
//  iRecipe
//
//  Created by Terry Li on 08/02/2026.
//

import Foundation

struct RecipeDetailReducer {
    func reduce(
        state: RecipeDetailState,
        intent: RecipeDetailIntent
    ) -> (RecipeDetailState, RecipeDetailEffect?) {

        switch (state, intent) {

        case (.idle(let isFavorite), .toggleFavorite):
            return (.idle(isFavorite: !isFavorite), nil)

        case (.idle, .share):
            return (state, .shareRecipe)
        }
    }
}
