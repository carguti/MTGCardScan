//
//  CardNamesResult.swift
//  MTGCardScan
//
//  Created by Carlos Gutiérrez Casado on 27/4/24.
//

import Foundation

struct CardNamesResult: Codable {
    let object: String
    let totalValues: Int
    let cardsNames: [String]
    
    enum CodingKeys: String, CodingKey {
        case object = "object"
        case totalValues = "total_values"
        case cardsNames = "data"
    }
}
