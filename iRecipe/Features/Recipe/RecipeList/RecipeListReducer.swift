//
//  RecipeListReducer.swift
//  iRecipe
//
//  Created by Meng Li on 08/02/2026.
//

import Foundation

struct RecipeListReducer {
    func reduce(state: RecipeListState, intent: RecipeListIntent) -> RecipeListState {
        var newState = state

        switch intent {
        case .onAppear:
            guard state.recipes.isEmpty else { return state }
            newState.isLoading = true
            newState.errorMessage = nil

        case .loadMore:
            guard state.hasMore,
                  !state.isLoading,
                  !state.isLoadingMore else {
                return state
            }
            
            newState.isLoadingMore = true

        case .retry:
            newState.isLoading = true
            newState.errorMessage = nil
            
        case .search(_):
            newState.isLoading = true
            newState.errorMessage = nil
            newState.loadedRecipes = newState.recipes
            newState.recipes = []
        
        case .cancelSearch:
            newState.errorMessage = nil
            newState.recipes = newState.loadedRecipes
        }

        return newState
    }
}
