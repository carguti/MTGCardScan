//
//  Dependencies.swift
//  MTGCardScan
//
//  Created by Carlos Gutiérrez Casado on 1/4/24.
//

import Foundation

class Dependencies {
    static var shared: Dependencies = .init()
    
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
        
    }
    
    func provideDependencies(testMode: Bool = false) {
        cardDependencies(testMode: testMode)
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
    private func cardDependencies(testMode: Bool = false) {
        if testMode {
            @Provider var cardWebRepository = MockCardWebRepository() as CardWebRepository
        } else {
            let baseUrl = "https://api.scryfall.com"
            
            @Provider var cardWebRepository = RealCardWebRepository(session: session, baseURL: baseUrl) as CardWebRepository
        }
    }
}

