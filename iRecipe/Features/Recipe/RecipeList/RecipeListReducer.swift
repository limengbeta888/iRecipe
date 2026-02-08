//
//  RecipeListReducer.swift
//  iRecipe
//
//  Created by Meng Li on 08/02/2026.
//

import Foundation

struct RecipeListReducer {
    func reduce(state: RecipeListState, intent: RecipeListIntent) -> RecipeListState {
        switch (state, intent) {
        case (_, .onAppear):
            return .loading

        case (_, .retry):
            return .loading

        default:
            return state
        }
    }
}
