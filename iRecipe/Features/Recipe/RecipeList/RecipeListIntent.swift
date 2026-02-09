//
//  RecipeListIntent.swift
//  iRecipe
//
//  Created by Meng Li on 08/02/2026.
//

import Foundation

enum RecipeListIntent: Equatable {
    case onAppear
    case loadMore
    case retry
    case search(String)
    case cancelSearch
}
