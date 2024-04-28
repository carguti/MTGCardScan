//
//  SearchScreenInteractor.swift
//  MTGCardScan
//
//  Created by Carlos Gutiérrez Casado on 27/4/24.
//

import Foundation

final class SearchScreenInteractor {
    @Inject var cardWebRepository: CardWebRepository
    
    private var cardsNamesResult: CardNamesResult?
    
    func getCardsNames(partialCardName: String) async throws -> CardNamesResult? {
        do {
            cardsNamesResult = try await cardWebRepository.getCardsNames(partialName: partialCardName)
            
            guard let cardsNamesResults = cardsNamesResult else {
                return nil
            }
            
            return cardsNamesResults
        } catch {
            print("Error getting cards names results: \(error)")
            throw error
        }
    }
}

extension SearchScreenInteractor {
    static var test: SearchScreenInteractor {
        Dependencies.shared.provideDependencies(testMode: true)
        
        let interactor = SearchScreenInteractor()
        
        return interactor
    }
}
