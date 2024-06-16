//
//  FavouritesCardsDDBBRepository.swift
//  MTGCardScan
//
//  Created by Carlos Gutiérrez Casado on 22/5/24.
//

import Foundation

protocol FavouritesCardsDDBBRepository {
    func store(card: Card) throws
    func getFavCards() throws -> [Card]
}

struct RealFavouritesCardsDDBBRepository: FavouritesCardsDDBBRepository {
    func store(card: Card) throws {
        if !UserDefaults.standard.favCards.contains(card) {
            UserDefaults.standard.favCards.append(card)
        } else {
            if let index = UserDefaults.standard.favCards.firstIndex(of: card) {
                UserDefaults.standard.favCards.remove(at: index)
                
                UserDefaults.standard.favCards.append(card)
            }
        }
    }
    
    func getFavCards() throws -> [Card] {
        return UserDefaults.standard.favCards.reversed()
    }
}

struct MockFavouritesCardsDDBBRepository: FavouritesCardsDDBBRepository {
    let storage = TestStorage<Card>()
    
    func store(card: Card) throws {
        storage.store(element: card)
    }
    
    func getFavCards() throws -> [Card] {
        return storage.getData()
    }
}
