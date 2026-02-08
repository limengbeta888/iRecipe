//
//  RecipeDetailIntent.swift
//  iRecipe
//
//  Created by Meng Li on 08/02/2026.
//

import Foundation

enum RecipeDetailIntent {
    case share(recipe: Recipe)
    case addFavorite
    case removeFavorite
}
