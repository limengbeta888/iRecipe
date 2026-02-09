//
//  RecipeService.swift
//  iRecipe
//
//  Created by Meng Li on 08/02/2026.
//

import Foundation

protocol RecipeServiceProtocol {
    func fetchRecipes(limit: Int, skip: Int) async throws -> RecipeResponse
    func searchRecipes(limit: Int, skip: Int, keyword: String) async throws -> RecipeResponse
}

final class RecipeService: RecipeServiceProtocol {
    private let networkClient: NetworkClientProtocol
    
    init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }
    
    func fetchRecipes(limit: Int, skip: Int) async throws -> RecipeResponse {
        let endpoint = RecipeEndpoint.recipes(limit: limit, skip: skip)
        return try await networkClient.request(endpoint: endpoint)
    }
    
    func searchRecipes(limit: Int, skip: Int, keyword: String) async throws -> RecipeResponse {
        let endpoint = RecipeEndpoint.searchRecipes(limit: limit, skip: skip, keyword: keyword)
        return try await networkClient.request(endpoint: endpoint)
    }
}
