//
//  NetworkClient.swift
//  iRecipe
//
//  Created by Meng Li on 08/02/2026.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}

protocol NetworkClientProtocol {
    func request<T: Decodable>(
        endpoint: String,
        method: HTTPMethod,
        queryParameters: [String: String]?,
        body: Encodable?,
        headers: [String: String]?
    ) async throws -> T
    
    func request<T: Decodable>(endpoint: Endpoint) async throws -> T
}

final class NetworkClient: NetworkClientProtocol {
    private let apiConfig: APIConfigProtocol
    private let session: URLSession
    private let decoder: JSONDecoder
    private let encoder: JSONEncoder
    
    init(
        apiConfig: APIConfigProtocol,
        session: URLSession = .shared,
        decoder: JSONDecoder = JSONDecoder(),
        encoder: JSONEncoder = JSONEncoder()
    ) {
        self.apiConfig = apiConfig
        self.session = session
        self.decoder = decoder
        self.encoder = encoder
    }
    
    func request<T: Decodable>(
        endpoint: String,
        method: HTTPMethod = .get,
        queryParameters: [String: String]? = nil,
        body: Encodable? = nil,
        headers: [String: String]? = nil
    ) async throws -> T {
        
        // Build URL
        let url = try buildURL(baseURL: apiConfig.baseURL, endpoint: endpoint, queryParameters: queryParameters)
        
        // Build Request
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        // Add headers
        if let headers {
            headers.forEach { key, value in
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        // Add body if present
        if let body = body {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try encoder.encode(body)
        }
        
        // Perform request
        let (data, response) = try await session.data(for: request)
        
        // Validate response
        try validateResponse(response)
        
        // Decode and return
        do {
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        } catch {
            throw NetworkError.decodingError(error)
        }
    }
    
    func request<T: Decodable>(endpoint: Endpoint) async throws -> T {
        try await request(
            endpoint: endpoint.path,
            method: endpoint.method,
            queryParameters: endpoint.queryParameters,
            body: endpoint.body,
            headers: endpoint.headers
        )
    }
    
    // MARK: - Private Helpers
    private func buildURL(
        baseURL: String,
        endpoint: String,
        queryParameters: [String: String]?
    ) throws -> URL {
        guard var components = URLComponents(string: "\(baseURL)\(endpoint)") else {
            throw NetworkError.invalidURL
        }
        
        if let queryParameters {
            components.queryItems = queryParameters.map { key, value in
                URLQueryItem(name: key, value: value)
            }
        }
        
        guard let url = components.url else {
            throw NetworkError.invalidURL
        }
        
        return url
    }
    
    private func validateResponse(_ response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        switch httpResponse.statusCode {
        case 200...299:
            return
        case 401:
            throw NetworkError.unauthorized
        case 404:
            throw NetworkError.notFound
        case 500...599:
            throw NetworkError.serverError(httpResponse.statusCode)
        default:
            throw NetworkError.httpError(httpResponse.statusCode)
        }
    }
}

// MARK: - Convenience Methods
extension NetworkClient {
    
    /// GET request
    func get<T: Decodable>(
        endpoint: String,
        queryParameters: [String: String]? = nil,
        headers: [String: String]? = nil
    ) async throws -> T {
        try await request(
            endpoint: endpoint,
            method: .get,
            queryParameters: queryParameters,
            body: nil as String?,
            headers: headers
        )
    }
    
    /// POST request
    func post<T: Decodable>(
        endpoint: String,
        body: Encodable,
        headers: [String: String]? = nil
    ) async throws -> T {
        try await request(
            endpoint: endpoint,
            method: .post,
            queryParameters: nil,
            body: body,
            headers: headers
        )
    }
    
    /// PUT request
    func put<T: Decodable>(
        baseURL: String,
        endpoint: String,
        body: Encodable,
        headers: [String: String]? = nil
    ) async throws -> T {
        try await request(
            endpoint: endpoint,
            method: .put,
            queryParameters: nil,
            body: body,
            headers: headers
        )
    }
    
    /// DELETE request
    func delete<T: Decodable>(
        baseURL: String,
        endpoint: String,
        headers: [String: String]? = nil
    ) async throws -> T {
        try await request(
            endpoint: endpoint,
            method: .delete,
            queryParameters: nil,
            body: nil as String?,
            headers: headers
        )
    }
}
