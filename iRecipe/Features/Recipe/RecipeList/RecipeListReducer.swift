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
                  !state.isSearching else {
                return state
            }
            
            newState.isLoading = true
            newState.errorMessage = nil

        case .retry:
            newState.isLoading = true
            newState.errorMessage = nil
            
        case .search(_):
            newState.isSearching = true
            newState.isLoading = true
            newState.errorMessage = nil
            newState.searchedRecipes = []
            newState.recipes = []
        
        case .cancelSearch:
            newState.isSearching = false
            newState.isLoading = false
            newState.errorMessage = nil
            newState.searchedRecipes = []
            newState.recipes = newState.loadedRecipes
        }

        return newState
    }
}
