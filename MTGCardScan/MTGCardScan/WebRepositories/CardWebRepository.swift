//
//  CardWebRepository.swift
//  MTGCardScan
//
//  Created by Carlos Gutiérrez Casado on 6/4/24.
//

import Foundation

protocol CardWebRepository: WebRepository {
    func getCard(name: String) async throws -> Card
    func getCardsNames(partialName: String) async throws -> CardNamesResult
}

struct RealCardWebRepository: CardWebRepository {
    let session: URLSession
    let baseURL: String
    
    init(session: URLSession, baseURL: String) {
        self.session = session
        self.baseURL = baseURL
    }
    
    // MARK: Get card
    func getCard(name: String) async throws -> Card {
        return try await call(endpoint: API.card(name: name))
    }
    
    // MARK: Get cards names
    func getCardsNames(partialName: String) async throws -> CardNamesResult {
        return try await call(endpoint: API.cardsNames(partialName: partialName))
    }
}

struct MockCardWebRepository: CardWebRepository {
    let session: URLSession = .mockedResponsesOnly
    let baseURL = "https://test.com"
    
    // MARK: Get card
    func getCard(name: String) async throws -> Card {
        let id = "8d94b8ec-ecda-43c8-a60e-1ba33e6a54a4"
        let cardName = "Edgar Markov"
        let lang = "en"
        let legalities = Legalities(standard: "not_legal", 
                                    modern: "not_legal",
                                    legacy: "not_legal",
                                    commander: "legal",
                                    pioneer: "not_legal",
                                    pauper: "not_legal")
        let foil = true
        let noFoil = false
        let prices = Prices(euro: nil, euroFoil: "92.31")
        let imageUris = Images(small: "https://cards.scryfall.io/small/front/8/d/8d94b8ec-ecda-43c8-a60e-1ba33e6a54a4.jpg?1562616128",
                               normal: "https://cards.scryfall.io/normal/front/8/d/8d94b8ec-ecda-43c8-a60e-1ba33e6a54a4.jpg?1562616128",
                               large: "https://cards.scryfall.io/large/front/8/d/8d94b8ec-ecda-43c8-a60e-1ba33e6a54a4.jpg?1562616128",
                               png: "https://cards.scryfall.io/png/front/8/d/8d94b8ec-ecda-43c8-a60e-1ba33e6a54a4.png?1562616128",
                               artCrop: "https://cards.scryfall.io/art_crop/front/8/d/8d94b8ec-ecda-43c8-a60e-1ba33e6a54a4.jpg?1562616128",
                               borderCrop: "https://cards.scryfall.io/border_crop/front/8/d/8d94b8ec-ecda-43c8-a60e-1ba33e6a54a4.jpg?1562616128")
        
        let relatedUris = RelatedUris(edhrec: "https://edhrec.com/route/?cc=Edgar+Markov")
        
        return Card(id: id, name: cardName, lang: lang, legalities: legalities, foil: foil, noFoil: noFoil, prices: prices, imageUris: imageUris, relatedUris: relatedUris, cardFaces: nil)
    }
    
    // MARK: Get cards names
    func getCardsNames(partialName: String) async throws -> CardNamesResult {
        let object = "catalog"
        let totalValues = 5
        let cardsNames = [
            "Edgar Markov",
            "Edgar's Awakening",
            "Edgar, Charmed Groom // Edgar Markov's Coffin",
            "Kami of the Tended Garden",
            "Case of the Trampled Garden"
        ]
        return CardNamesResult(object: object, totalValues: totalValues, cardsNames: cardsNames)
    }
}

extension RealCardWebRepository {
    enum API {
        case card(name: String)
        case cardsNames(partialName: String)
    }
}

extension RealCardWebRepository.API: APICall {
    var path: String {
        switch self {
        case .card(let name):
            return "/cards/named?fuzzy=\(name.replacingOccurrences(of: " ", with: "+"))"
        case .cardsNames(let partialName):
            return "/cards/autocomplete?q=\(partialName.replacingOccurrences(of: " ", with: "+"))"
        }
    }
        
    var method: HTTPMethod {
        switch self {
        case .card:
            return .get
        case .cardsNames:
            return .get
        }
    }
    
    func headers() throws -> [String: String]? {
        return [
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
    }
        
    func body() throws -> Data? {
        switch self {
        case .card:
            return nil
        case .cardsNames:
            return nil
        }
    }
}

extension URLSession {
    static var mockedResponsesOnly: URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 1
        configuration.timeoutIntervalForResource = 1
        return URLSession(configuration: configuration)
    }
}
