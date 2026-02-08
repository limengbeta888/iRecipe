//
//  APIConfig.swift
//  iRecipe
//
//  Created by Meng Li on 08/02/2026.
//

enum APPEnvironment {
    case development
    case staging
    case production
}

protocol APIConfigProtocol {
    var baseURL: String { get }
}

final class APIConfig: APIConfigProtocol {
    private(set) var baseURL: String
    
    private let developmentBaseURL = "https://dummyjson.com"
    private let stagingBaseURL = "https://dummyjson.com"
    private let productionBaseURL = "https://dummyjson.com"
    
    init() {
        self.baseURL = developmentBaseURL
    }
    
    func switchTo(environment: APPEnvironment) {
        switch environment {
        case .development:
            self.baseURL = developmentBaseURL
        case .staging:
            self.baseURL = stagingBaseURL
        case .production:
            self.baseURL = productionBaseURL
        }
    }
}
