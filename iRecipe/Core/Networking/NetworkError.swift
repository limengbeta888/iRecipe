//
//  NetworkError.swift
//  iRecipe
//
//  Created by Meng Li on 08/02/2026.
//

import Foundation

enum NetworkError: Error, LocalizedError, Equatable {
    case invalidURL
    case invalidResponse
    case decodingError(Error)
    case encodingError(Error)
    case noData
    case unauthorized
    case notFound
    case serverError(Int)
    case httpError(Int)
    case networkError(Error)
    case timeout
    case noInternetConnection
    
    // MARK: - Error Description
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL is invalid"
        case .invalidResponse:
            return "Invalid response from server"
        case .decodingError(let error):
            return "Failed to decode response: \(error.localizedDescription)"
        case .encodingError(let error):
            return "Failed to encode request: \(error.localizedDescription)"
        case .noData:
            return "No data received from server"
        case .unauthorized:
            return "Unauthorized. Please log in again."
        case .notFound:
            return "The requested resource was not found"
        case .serverError(let code):
            return "Server error (\(code)). Please try again later."
        case .httpError(let code):
            return "HTTP error: \(code)"
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        case .timeout:
            return "Request timed out. Please check your connection."
        case .noInternetConnection:
            return "No internet connection. Please check your network settings."
        }
    }
    
    // MARK: - User-Friendly Message
    var userFriendlyMessage: String {
        switch self {
        case .invalidURL, .invalidResponse, .decodingError, .encodingError:
            return "Something went wrong. Please try again."
        case .noData:
            return "No data available at the moment."
        case .unauthorized:
            return "Please log in to continue."
        case .notFound:
            return "The content you're looking for doesn't exist."
        case .serverError:
            return "Our servers are having issues. Please try again later."
        case .httpError:
            return "Something went wrong. Please try again."
        case .networkError, .timeout, .noInternetConnection:
            return "Please check your internet connection and try again."
        }
    }
    
    // MARK: - Equatable Conformance
    static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidURL, .invalidURL),
             (.invalidResponse, .invalidResponse),
             (.noData, .noData),
             (.unauthorized, .unauthorized),
             (.notFound, .notFound),
             (.timeout, .timeout),
             (.noInternetConnection, .noInternetConnection):
            return true
        case (.serverError(let lCode), .serverError(let rCode)),
             (.httpError(let lCode), .httpError(let rCode)):
            return lCode == rCode
        case (.decodingError(let lError), .decodingError(let rError)),
             (.encodingError(let lError), .encodingError(let rError)),
             (.networkError(let lError), .networkError(let rError)):
            return lError.localizedDescription == rError.localizedDescription
        default:
            return false
        }
    }
}
