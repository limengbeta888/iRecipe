//
//  RecipeListResult.swift
//  iRecipe
//
//  Created by Meng Li on 08/02/2026.
//

enum RecipeListResult: Equatable {
    case loading
    case success([Recipe])
    case failure(String)
}
