//
//  CardPrintsWebRepository.swift
//  MTGCardScan
//
//  Created by Carlos Gutiérrez Casado on 15/5/24.
//

import Foundation

protocol CardPrintsWebRepository: WebRepository {
    func getCardPrints(printsUri: String) async throws -> CardPrints
}

struct RealCardPrintsWebRepository: CardPrintsWebRepository {
    let session: URLSession
    let baseURL: String
    
    init(session: URLSession, baseURL: String) {
        self.session = session
        self.baseURL = baseURL
    }
    
    // MARK: Get card prints
    func getCardPrints(printsUri: String) async throws -> CardPrints {
        return try await call(endpoint: API.cardPrints(printsUri: printsUri))
    }
}

struct MockCardPrintsWebRepository: CardPrintsWebRepository {
    
    let session: URLSession = .mockedResponsesOnly
    let baseURL = "https://test.com"
    
    // MARK: Get card prints
    func getCardPrints(printsUri: String) async throws -> CardPrints {
        let id = "8c936967-b8eb-4d32-a6cc-c6bb006023d3"
        let name = "Edgar Markov"
        let object = "list"
        let totalCards = 4
        let hasMore = false
        let prices = Prices(euro: nil, euroFoil: "235.59")
        let imagesUris = Images(small: "https://cards.scryfall.io/small/front/8/c/8c936967-b8eb-4d32-a6cc-c6bb006023d3.jpg?1641097591",
                                normal: "https://cards.scryfall.io/normal/front/8/c/8c936967-b8eb-4d32-a6cc-c6bb006023d3.jpg?1641097591",
                                large: "https://cards.scryfall.io/large/front/8/c/8c936967-b8eb-4d32-a6cc-c6bb006023d3.jpg?1641097591",
                                png: "https://cards.scryfall.io/png/front/8/c/8c936967-b8eb-4d32-a6cc-c6bb006023d3.png?1641097591",
                                artCrop: "https://cards.scryfall.io/art_crop/front/8/c/8c936967-b8eb-4d32-a6cc-c6bb006023d3.jpg?1641097591",
                                borderCrop: "https://cards.scryfall.io/border_crop/front/8/c/8c936967-b8eb-4d32-a6cc-c6bb006023d3.jpg?1641097591")
        let purchaseUris = PurchaseUris(cardmarket: "https://www.cardmarket.com/en/Magic/Products/Singles/Judge-Rewards-Promos/Edgar-Markov?referrer=scryfall&utm_campaign=card_prices&utm_medium=text&utm_source=scryfall")
        
        let cardFaces = [CardFace(name: "Brutal Cathar", imagesUris: Images(small: "https://cards.scryfall.io/small/front/7/2/72df9225-eb06-4f3a-94a5-844c9f6869c7.jpg?1673158557", normal: "https://cards.scryfall.io/small/front/7/2/72df9225-eb06-4f3a-94a5-844c9f6869c7.jpg?1673158557", large: "https://cards.scryfall.io/small/front/7/2/72df9225-eb06-4f3a-94a5-844c9f6869c7.jpg?1673158557", png: "https://cards.scryfall.io/small/front/7/2/72df9225-eb06-4f3a-94a5-844c9f6869c7.jpg?1673158557", artCrop: "https://cards.scryfall.io/small/front/7/2/72df9225-eb06-4f3a-94a5-844c9f6869c7.jpg?1673158557", borderCrop: "https://cards.scryfall.io/small/front/7/2/72df9225-eb06-4f3a-94a5-844c9f6869c7.jpg?1673158557"))]
        
        let cardPintsInfo = [CardPrintsInfo(id: id, name: name, setName: "Judge Gift Cards 2021", prices: prices, imageUris: imagesUris, purchaseUris: purchaseUris, cardFaces: cardFaces)]
        
        return CardPrints(object: object, totalCards: totalCards, hasMore: hasMore, cardPrints: cardPintsInfo)
    }
    
    
    
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
        let printSearchUris = "https://api.scryfall.com/cards/search?order=released&q=oracleid%3A41e2790d-49f5-4e98-b8d9-04179f47f13a&unique=prints"
        let purchaseUris = PurchaseUris(cardmarket: "https://www.cardmarket.com/en/Magic/Products/Singles/Judge-Rewards-Promos/Edgar-Markov?referrer=scryfall&utm_campaign=card_prices&utm_medium=text&utm_source=scryfall")
        
        return Card(id: id, name: cardName, lang: lang, legalities: legalities, foil: foil, noFoil: noFoil, prices: prices, imageUris: imageUris, relatedUris: relatedUris, cardFaces: nil, printsSearchUri: printSearchUris, purchaseUris: purchaseUris)
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

extension RealCardPrintsWebRepository {
    enum API {
        case cardPrints(printsUri: String)
    }
}

extension RealCardPrintsWebRepository.API: APICall {
    var path: String {
        switch self {
        case .cardPrints(let printsUri):
            return "\(printsUri)"
        }
    }
        
    var method: HTTPMethod {
        switch self {
        case .cardPrints:
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
        case .cardPrints:
            return nil
        }
    }
}



