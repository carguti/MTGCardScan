//
//  CardsHistorialVM.swift
//  MTGCardScan
//
//  Created by Carlos Gutiérrez Casado on 22/5/24.
//

import SwiftUI

class CardsHistorialVM: ObservableObject {
    private var interactor = CardsHistorialInteractor()
    
    @Published var cardsHistorial: [Card] = []
    
    // MARK: Init
    init(interactor: CardsHistorialInteractor) {
        self.interactor = interactor
    }
    
    func storeCardHistorial(card: Card) {
        do {
            try interactor.cardsHistorialDBRepository.store(card: card)
        } catch {
            print("Error storing card historial")
        }
    }
    
    //MARK: Get cards historial
    @MainActor func getCardHistorial() -> [Card] {
        do {
            Task {
                cardsHistorial = try await interactor.getCardsHistorial()
                return cardsHistorial
            }
        } catch {
            print("Error getting cards historial")
            return cardsHistorial
        }
        
        return cardsHistorial
    }
}
