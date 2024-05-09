//
//  Card.swift
//  MTGCardScan
//
//  Created by Carlos Gutiérrez Casado on 6/4/24.
//

import Foundation

struct Card: Codable, Identifiable, Hashable {
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
    }
    
    let id: String
    let name: String
    let lang: String
    let legalities: Legalities
    let foil: Bool
    let noFoil: Bool
    let prices: Prices
    let imageUris: Images?
    let relatedUris: RelatedUris
    let cardFaces: [CardFace]?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case lang = "lang"
        case legalities = "legalities"
        case foil = "foil"
        case noFoil = "nonfoil"
        case prices = "prices"
        case imageUris = "image_uris"
        case relatedUris = "related_uris"
        case cardFaces = "card_faces"
    }
}

struct Legalities: Codable {
    let standard: String
    let modern: String
    let legacy: String
    let commander: String
    let pioneer: String
    let pauper: String
    
    enum CodingKeys: String, CodingKey {
        case standard = "standard"
        case modern = "modern"
        case legacy = "legacy"
        case commander = "commander"
        case pioneer = "pioneer"
        case pauper = "pauper"
    }
}

struct Prices: Codable {
    let euro: String?
    let euroFoil: String?
    
    enum CodingKeys: String, CodingKey {
        case euro = "eur"
        case euroFoil = "eur_foil"
    }
}

struct Images: Codable {
    let small: String
    let normal: String
    let large: String
    let png: String
    let artCrop: String
    let borderCrop: String
    
    enum CodingKeys: String, CodingKey {
        case small = "small"
        case normal = "normal"
        case large = "large"
        case png = "png"
        case artCrop = "art_crop"
        case borderCrop = "border_crop"
    }
}

struct RelatedUris: Codable {
    let edhrec: String
}

struct CardFace: Codable {
    let name: String
    let imagesUris: Images
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case imagesUris = "image_uris"
    }
}

