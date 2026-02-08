//
//  RecipeEndpoint.swift
//  iRecipe
//
//  Created by Meng Li on 08/02/2026.
//

enum RecipeEndpoint: Endpoint {
    case recipes(limit: Int, skip: Int)
    case recipeDetail(id: Int)
    case searchRecipes(query: String)
    
    var path: String {
        switch self {
        case .recipes:
            return "/recipes"
        case .recipeDetail(let id):
            return "/recipes/\(id)"
        case .searchRecipes:
            return "/recipes/search"
        }
    }
    
    var queryParameters: [String: String]? {
        switch self {
        case .recipes(let limit, let skip):
            return [
                "limit": "\(limit)",
                "skip": "\(skip)"
            ]
        case .searchRecipes(let query):
            return ["q": query]
        case .recipeDetail:
            return nil
        }
    }
}
