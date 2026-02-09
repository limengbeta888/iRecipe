//
//  MockRecipeService.swift
//  iRecipe
//
//  Created by Meng Li on 09/02/2026.
//

final class MockRecipeService: RecipeServiceProtocol {
    var fetchRecipesResult: Result<RecipeResponse, Error>!
    var searchRecipesResult: Result<RecipeResponse, Error>!

    func fetchRecipes(limit: Int, skip: Int) async throws -> RecipeResponse {
        try fetchRecipesResult.get()
    }

    func searchRecipes(limit: Int, skip: Int, keyword: String) async throws -> RecipeResponse {
        try searchRecipesResult.get()
    }
}
