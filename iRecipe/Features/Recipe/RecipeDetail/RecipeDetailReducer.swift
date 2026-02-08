//
//  RecipeDetailReducer.swift
//  iRecipe
//
//  Created by Terry Li on 08/02/2026.
//

import Foundation

struct RecipeDetailReducer {
    func reduce(state: RecipeDetailState, intent: RecipeDetailIntent) -> RecipeDetailState {
        switch (state, intent) {
        case (_, .addFavorite):
            return .favorite(true)

        case (_, .removeFavorite):
            return .favorite(false)
   
        default:
            return state
        }
    }
}
