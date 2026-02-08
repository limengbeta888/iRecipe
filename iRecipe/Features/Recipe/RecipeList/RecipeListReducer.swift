//
//  RecipeListReducer.swift
//  iRecipe
//
//  Created by Meng Li on 08/02/2026.
//

import Foundation

struct RecipeListReducer {
    func reduce(
        state: RecipeListState,
        result: RecipeListResult
    ) -> RecipeListState {
        switch result {
        case .loading:
            return .loading

        case .success(let recipes):
            return .loaded(recipes)

        case .failure(let message):
            return .error(message)
        }
    }
}
