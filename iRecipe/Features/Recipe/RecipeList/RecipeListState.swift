//
//  RecipeListState.swift
//  iRecipe
//
//  Created by Meng Li on 08/02/2026.
//

import Foundation

struct RecipeListState: Equatable {
    var recipes: [Recipe] = []
    var loadedRecipes: [Recipe] = []
    var isLoading: Bool = false
    var isLoadingMore: Bool = false
    var hasMore: Bool = true
    var errorMessage: String? = nil
}
