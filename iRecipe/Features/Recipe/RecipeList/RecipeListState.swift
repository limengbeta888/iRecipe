//
//  RecipeListState.swift
//  iRecipe
//
//  Created by Meng Li on 08/02/2026.
//

import Foundation

struct RecipeListState: Equatable {
    var recipes: [Recipe] = []
    var isLoading: Bool = false
    var isLoadingMore: Bool = false
    var errorMessage: String? = nil
    var hasMore: Bool = true
}
