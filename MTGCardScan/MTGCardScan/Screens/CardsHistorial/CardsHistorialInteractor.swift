//
//  CardsHistorialInteractor.swift
//  MTGCardScan
//
//  Created by Carlos Gutiérrez Casado on 22/5/24.
//

import SwiftUI

final class CardsHistorialInteractor {
    @Inject var cardsHistorialDBRepository: CardsHistorialDDBBRepository
    
    private var cardsHistorial: [Card] = []
    
    // MARK: Get card historial
    func getCardsHistorial() async throws -> [Card] {
        do {
            cardsHistorial = try cardsHistorialDBRepository.getCardsHistorial()
            
            guard cardsHistorial.count > 0 else {
                return []
            }
            
            return cardsHistorial
        } catch {
            print("Error getting cards historial: \(error)")
            throw error
        }
    }
}

extension CardsHistorialInteractor {
    static var test: CardsHistorialInteractor {
        Dependencies.shared.provideDependencies(testMode: true)
        
        let interactor = CardsHistorialInteractor()
        
        return interactor
    }
}
