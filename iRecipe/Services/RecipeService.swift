//
//  RecipeService.swift
//  iRecipe
//
//  Created by Meng Li on 08/02/2026.
//

import Foundation

// MARK: - Network Error
enum NetworkError: Error, LocalizedError {
    case invalidResponse
}

// MARK: - Recipe Service Protocol
protocol RecipeServiceProtocol {
    func fetchRecipes(limit: Int, skip: Int) async throws -> RecipeResponse
}

// MARK: - Recipe Service Implementation
final class RecipeService: RecipeServiceProtocol {
    func fetchRecipes(limit: Int = 10, skip: Int = 0) async throws -> RecipeResponse {
        throw NetworkError.invalidResponse
    }
}
