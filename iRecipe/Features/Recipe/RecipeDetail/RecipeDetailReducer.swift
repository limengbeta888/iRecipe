//
//  RecipeDetailReducer.swift
//  iRecipe
//
//  Created by Meng Li on 08/02/2026.
//

import Foundation

struct RecipeDetailReducer {
    func reduce(
        state: RecipeDetailState,
        intent: RecipeDetailIntent
    ) -> (RecipeDetailState, RecipeDetailEffect?) {

        switch intent {
        case .share:
            return (state, .shareRecipe)
        }
    }
}
