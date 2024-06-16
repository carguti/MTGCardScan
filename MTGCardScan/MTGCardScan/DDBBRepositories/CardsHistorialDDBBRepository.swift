//
//  CardsHistorialDDBBRepository.swift
//  MTGCardScan
//
//  Created by Carlos Gutiérrez Casado on 22/5/24.
//

import Foundation

protocol CardsHistorialDDBBRepository {
    func store(card: Card) throws
    func getCardsHistorial() throws -> [Card]
}

struct RealCardsHistorialDDBBRepository: CardsHistorialDDBBRepository {
    func store(card: Card) throws {
        if !UserDefaults.standard.cardsHistorial.contains(card) {
            UserDefaults.standard.cardsHistorial.append(card)
        } else {
            if let index = UserDefaults.standard.cardsHistorial.firstIndex(of: card) {
                UserDefaults.standard.cardsHistorial.remove(at: index)
                
                UserDefaults.standard.cardsHistorial.append(card)
            }
        }
    }
    
    func getCardsHistorial() throws -> [Card] {
        return UserDefaults.standard.cardsHistorial.reversed()
    }
}

struct MockCardsHistorialDDBBRepository: CardsHistorialDDBBRepository {
    let storage = TestStorage<Card>()
    
    func store(card: Card) throws {
        storage.store(element: card)
    }
    
    func getCardsHistorial() throws -> [Card] {
        return storage.getData()
    }
}
