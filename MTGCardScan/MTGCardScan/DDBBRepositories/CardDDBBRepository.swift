//
//  CardDDBBRepository.swift
//  MTGCardScan
//
//  Created by Carlos Gutiérrez Casado on 15/4/24.
//

import Foundation

protocol CardDDBBRepository {
    func store(card: Card) throws
    func getCards() throws -> [Card]
}

struct RealCardDDBBRepository: CardDDBBRepository {
    func store(card: Card) throws {
        
    }
    
    func getCards() throws -> [Card] {
        return []
    }
}

struct MockCardDDBBRepository: CardDDBBRepository {
    let storage = TestStorage<Card>()
    
    func store(card: Card) throws {
        storage.store(element: card)
    }
    
    func getCards() throws -> [Card] {
        return storage.getData()
    }
}

class TestStorage<T> where T: Identifiable {
    var storage: [T] = []
    
    func store(element: T) {
        if let idx = storage.firstIndex(where: { $0.id == element.id }) {
            storage[idx] = element
        } else {
            storage.append(element)
        }
    }
    
    func getData() -> [T] {
        return storage
    }
    
    func getElement(id: T.ID) -> T? {
        return storage.first { $0.id == id }
    }
}

