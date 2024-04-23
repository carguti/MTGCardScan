//
//  CardInteractor.swift
//  MTGCardScan
//
//  Created by Carlos Gutiérrez Casado on 14/4/24.
//

import Foundation

final class CardInteractor {
    func getCard(name: String) async throws -> Card {
        @Inject var cardWebRepository: CardWebRepository
        
        let card = try await cardWebRepository.getCard(name: name)
        
        return card
    }
}
