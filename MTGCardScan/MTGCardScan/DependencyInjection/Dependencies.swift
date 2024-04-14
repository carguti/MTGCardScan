//
//  Dependencies.swift
//  MTGCardScan
//
//  Created by Carlos Gutiérrez Casado on 1/4/24.
//

import Foundation

class Dependencies {
    var session: URLSession {
        let configuration = URLSessionConfiguration.default
        
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 120
        configuration.waitsForConnectivity = true
        configuration.httpMaximumConnectionsPerHost = 5
        configuration.requestCachePolicy = .reloadIgnoringCacheData
        configuration.urlCache = .shared
        
        return URLSession(configuration: configuration)
    }
    
    init() {
        usersDependencies()
    }
    
    // MARK: - Test data
    
    static var test: Dependencies {
        return Dependencies(testMode: true)
    }
    
    private init(testMode: Bool) {
        usersDependencies(testMode: testMode)
    }
    
    // MARK: - Private methods
    
    private func configuredURLSession() -> URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 120
        configuration.waitsForConnectivity = true
        configuration.httpMaximumConnectionsPerHost = 5
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        configuration.urlCache = .shared
        return URLSession(configuration: configuration)
    }
}

// MARK: - Login dependencies

extension Dependencies {
    private func usersDependencies(testMode: Bool = false) {
        if testMode {
            @Provider var usersWebRepository = MockCardWebRepository() as CardWebRepository
        } else {
            let baseUrl = "https://api.scryfall.com"
            
            @Provider var cardWebRepository = RealCardWebRepository(session: session, baseURL: baseUrl) as CardWebRepository
        }
    }
}

