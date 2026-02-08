//
//  Endpoint.swift
//  iRecipe
//
//  Created by Meng Li on 08/02/2026.
//

import Foundation

protocol Endpoint {
    var path: String { get }
    var method: HTTPMethod { get }
    var queryParameters: [String: String]? { get }
    var headers: [String: String]? { get }
    var body: Encodable? { get }
}

// MARK: - Default Implementations
extension Endpoint {
    var method: HTTPMethod { .get }
    var queryParameters: [String: String]? { nil }
    var headers: [String: String]? { nil }
    var body: Encodable? { nil }
}
