//
//  APICall.swift
//  MTGCardScan
//
//  Created by Carlos Gutiérrez Casado on 1/4/24.
//

import Foundation

enum HTTPMethod: String {
    case get  = "GET"
    case post = "POST"
}

protocol APICall {
    var path: String { get }
    var method: HTTPMethod { get }
    func headers() async throws -> [String: String]?
    func body() throws -> Data?
}

enum APIError: Swift.Error {
    case invalidURL
    case unauthorized
    case httpCode(HTTPCode)
    case unexpectedResponse
    case decoding(Error)
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL"
        case .unauthorized: return "Unauthorized"
        case let .httpCode(code): return "Unexpected HTTP code: \(code)"
        case .unexpectedResponse: return "Unexpected response from the server"
        case let .decoding(error): return "Error decoding: \(error)"
        }
    }
}

extension APICall {
    func urlRequest(baseURL: String) async throws -> URLRequest {
        let fullURL = baseURL + path
        
        guard let url = URL(string: fullURL) else {
            throw APIError.invalidURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = try await headers()
        request.httpBody = try body()
        return request
    }
}

typealias HTTPCode = Int
typealias HTTPCodes = Range<HTTPCode>

extension HTTPCodes {
    static let success = 200 ..< 300
}
