//
//  SearchScreenInteractor.swift
//  MTGCardScan
//
//  Created by Carlos Gutiérrez Casado on 27/4/24.
//

import Foundation
import SwiftUI

final class SearchScreenInteractor {
    @Inject var cardWebRepository: CardWebRepository
    
    private var cardsNamesResult: CardNamesResult?
    private var card: Card?
    private var cards: [Card] = []
    
    // MARK: Get cards by partial name
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
    
    // MARK: Get card by name
    func getCard(cardName: String) async throws -> [Card]? {
        cards.removeAll()
        
        do {
            cardsNamesResult = try await cardWebRepository.getCardsNames(partialName: cardName)
            
            guard let cardsNamesResults = cardsNamesResult?.cardsNames else {
                return nil
            }
            
            for cardName in cardsNamesResults {
                card = try await cardWebRepository.getCard(name: cardName)
                
                guard let card = card else {
                    return nil
                }
                
                cards.append(card)
            }
            
            return cards
        } catch {
            print("Error getting card: \(error)")
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
