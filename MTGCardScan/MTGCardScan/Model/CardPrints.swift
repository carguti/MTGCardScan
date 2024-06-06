//
//  CardPrints.swift
//  MTGCardScan
//
//  Created by Carlos Gutiérrez Casado on 15/5/24.
//

import Foundation

struct CardPrints: Codable {
    let object: String
    let totalCards: Int
    let hasMore: Bool
    let cardPrints: [CardPrintsInfo]
    
    enum CodingKeys: String, CodingKey {
        case object = "object"
        case totalCards = "total_cards"
        case hasMore = "has_more"
        case cardPrints = "data"
    }
}

struct CardPrintsInfo: Codable, Identifiable, Hashable {
    static func == (lhs: CardPrintsInfo, rhs: CardPrintsInfo) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
    }
    
    let id: String
    let name: String
    let setName: String
    let prices: Prices
    let imageUris: Images?
    let purchaseUris: PurchaseUris
    let cardFaces: [CardFace]?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case setName = "set_name"
        case prices = "prices"
        case imageUris = "image_uris"
        case purchaseUris = "purchase_uris"
        case cardFaces = "card_faces"
    }
}
