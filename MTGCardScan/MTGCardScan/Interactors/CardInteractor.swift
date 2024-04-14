//
//  CardInteractor.swift
//  MTGCardScan
//
//  Created by Carlos Gutiérrez Casado on 14/4/24.
//

import Foundation

final class CardInteractor {
    func getCard(collectionCode: String, cardNumber: Int, lang: String?) async throws -> Card {
        @Inject var cardWebRepository: CardWebRepository
        
        let card = try await cardWebRepository.getCard(collectionCode: collectionCode, cardNumber: cardNumber, lang: lang)
        
        return card
    }
}
