//
//  RecipeListState.swift
//  iRecipe
//
//  Created by Meng Li on 08/02/2026.
//

import Foundation

enum RecipeListState: Equatable {
    case idle
    case loading
    case loaded([Recipe])
    case error(String)
}
