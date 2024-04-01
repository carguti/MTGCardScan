//
//  WebRepository.swift
//  MTGCardScan
//
//  Created by Carlos Gutiérrez Casado on 1/4/24.
//

import Foundation

protocol WebRepository {
    var session: URLSession { get }
    var baseURL: String { get }
    var decoder: JSONDecoder { get }
}

extension WebRepository {
    var decoder: JSONDecoder {
        return JSONDecoder()
    }
}

extension WebRepository {
    func call<T: Codable>(endpoint: APICall, httpCodes: HTTPCodes = .success) async throws -> T {
        let request = try await endpoint.urlRequest(baseURL: baseURL)
        
        let (data, response) = try await session.data(for: request)
        
        guard let code = (response as? HTTPURLResponse)?.statusCode else {
            throw APIError.unexpectedResponse
        }
        
        guard httpCodes.contains(code) else {
            throw APIError.httpCode(code)
        }
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw APIError.decoding(error)
        }
    }
    
    func callNoResponse(endpoint: APICall, httpCodes: HTTPCodes = .success) async throws {
        let request = try await endpoint.urlRequest(baseURL: baseURL)
        
        let (_, response) = try await session.data(for: request)
        
        guard let code = (response as? HTTPURLResponse)?.statusCode else {
            throw APIError.unexpectedResponse
        }
        
        guard httpCodes.contains(code) else {
            throw APIError.httpCode(code)
        }
    }
    
    func callGetData(endpoint: APICall, httpCodes: HTTPCodes = .success, isRetry: Bool = false) async throws -> Data {
        let request = try await endpoint.urlRequest(baseURL: baseURL)
        
        let (data, response) = try await session.data(for: request)
        
        guard let _ = (response as? HTTPURLResponse)?.statusCode else {
            throw APIError.unexpectedResponse
        }
        
        return data
    }
}
