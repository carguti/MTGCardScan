//
//  SearchResultInteractor.swift
//  MTGCardScan
//
//  Created by Carlos Gutiérrez Casado on 15/5/24.
//

import Foundation
import SwiftUI

final class SearchResultInteractor {
    @Inject var cardPrintsWebRepository: CardPrintsWebRepository
    
    private var cardPrints: [CardPrintsInfo] = []
    
    // MARK: Get cardPrints
    func getCardPrints(printsUri: String) async throws -> [CardPrintsInfo]? {
        do {
            cardPrints = try await cardPrintsWebRepository.getCardPrints(printsUri: printsUri).cardPrints
            
            guard cardPrints.count > 0 else {
                return nil
            }
            
            return cardPrints
        } catch {
            print("Error getting cards names results: \(error)")
            throw error
        }
    }
}

extension SearchResultInteractor {
    static var test: SearchResultInteractor {
        Dependencies.shared.provideDependencies(testMode: true)
        
        let interactor = SearchResultInteractor()
        
        return interactor
    }
}
