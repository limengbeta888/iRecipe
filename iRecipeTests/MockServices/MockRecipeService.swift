//
//  MockRecipeService.swift
//  iRecipe
//
//  Created by Meng Li on 08/02/2026.
//

@testable import iRecipe

final class MockRecipeService: RecipeServiceProtocol {
    var result: Result<RecipeResponse, Error>!

    func fetchRecipes(limit: Int, skip: Int) async throws -> RecipeResponse {
        switch result! {
        case .success(let response):
            return response
        case .failure(let error):
            throw error
        }
    }
}
