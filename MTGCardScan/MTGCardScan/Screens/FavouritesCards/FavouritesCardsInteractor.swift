//
//  FavouritesCardsInteractor.swift
//  MTGCardScan
//
//  Created by Carlos Gutiérrez Casado on 22/5/24.
//

import SwiftUI

final class FavouritesCardsInteractor {
    @Inject var favCardsDDBBRepository: FavouritesCardsDDBBRepository
    
    private var favCards: [Card] = []
    
    // MARK: Get card historial
    func getFavCards() async throws -> [Card] {
        do {
            favCards = try favCardsDDBBRepository.getFavCards()
            
            guard favCards.count > 0 else {
                return []
            }
            
            return favCards
        } catch {
            print("Error getting fav cards: \(error)")
            throw error
        }
    }
}

extension FavouritesCardsInteractor {
    static var test: FavouritesCardsInteractor {
        Dependencies.shared.provideDependencies(testMode: true)
        
        let interactor = FavouritesCardsInteractor()
        
        return interactor
    }
}
