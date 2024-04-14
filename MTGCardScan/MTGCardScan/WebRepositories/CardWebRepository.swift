//
//  CardWebRepository.swift
//  MTGCardScan
//
//  Created by Carlos Gutiérrez Casado on 6/4/24.
//

import Foundation

protocol CardWebRepository: WebRepository {
    func getCard(collectionCode: String, cardNumber: Int, lang: String?) async throws -> Card
}

struct RealCardWebRepository: CardWebRepository {
    let session: URLSession
    let baseURL: String
    
    init(session: URLSession, baseURL: String) {
        self.session = session
        self.baseURL = baseURL
    }
    
    func getCard(collectionCode: String, cardNumber: Int, lang: String?) async throws -> Card {
        return try await call(endpoint: API.card(collectionCode: collectionCode, cardNumber: cardNumber, lang: lang))
    }
}

struct MockCardWebRepository: CardWebRepository {
    let session: URLSession = .mockedResponsesOnly
    let baseURL = "https://test.com"
    
    func getCard(collectionCode: String, cardNumber: Int, lang: String?) async throws -> Card {
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
        let prices = Prices(euro: nil, euroFoil: 92.31)
        let imageUris = Images(small: "https://cards.scryfall.io/small/front/8/d/8d94b8ec-ecda-43c8-a60e-1ba33e6a54a4.jpg?1562616128",
                               normal: "https://cards.scryfall.io/normal/front/8/d/8d94b8ec-ecda-43c8-a60e-1ba33e6a54a4.jpg?1562616128",
                               large: "https://cards.scryfall.io/large/front/8/d/8d94b8ec-ecda-43c8-a60e-1ba33e6a54a4.jpg?1562616128",
                               png: "https://cards.scryfall.io/png/front/8/d/8d94b8ec-ecda-43c8-a60e-1ba33e6a54a4.png?1562616128",
                               artCrop: "https://cards.scryfall.io/art_crop/front/8/d/8d94b8ec-ecda-43c8-a60e-1ba33e6a54a4.jpg?1562616128",
                               borderCrop: "https://cards.scryfall.io/border_crop/front/8/d/8d94b8ec-ecda-43c8-a60e-1ba33e6a54a4.jpg?1562616128")
        
        let relatedUris = RelatedUris(edhrec: "https://edhrec.com/route/?cc=Edgar+Markov")
        
        return Card(name: cardName, lang: lang, legalities: legalities, foil: foil, noFoil: noFoil, prices: prices, imageUris: imageUris, relatedUris: relatedUris, cardFaces: nil)
    }
}

extension RealCardWebRepository {
    enum API {
        case card(collectionCode: String, cardNumber: Int, lang: String?)
    }
}

extension RealCardWebRepository.API: APICall {
    var path: String {
        switch self {
        case .card(let collectionCode, let cardNumber, let lang):
            return "/cards/\(collectionCode)/\(cardNumber)/\(lang ?? "")"
        }
    }
        
    var method: HTTPMethod {
        switch self {
        case .card:
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
