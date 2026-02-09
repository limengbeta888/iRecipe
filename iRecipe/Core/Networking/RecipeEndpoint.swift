//
//  RecipeEndpoint.swift
//  iRecipe
//
//  Created by Meng Li on 08/02/2026.
//

enum RecipeEndpoint: Endpoint {
    case recipes(limit: Int, skip: Int)
    case searchRecipes(limit: Int, skip: Int, keyword: String)
    
    var path: String {
        switch self {
        case .recipes:
            return "/recipes"
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
        case .searchRecipes(let limit, let skip, let keyword):
            return [
                "q": "\(keyword)",
                "limit": "\(limit)",
                "skip": "\(skip)",
            ]
        }
    }
}
