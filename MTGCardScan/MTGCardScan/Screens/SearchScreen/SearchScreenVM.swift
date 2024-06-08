//
//  SearchScreenVM.swift
//  MTGCardScan
//
//  Created by Carlos Gutiérrez Casado on 27/4/24.
//

import SwiftUI

class SearchScreenVM: ObservableObject {
    private var interactor = SearchScreenInteractor()
    
    @Published var card: Card?
    @Published var cardsByName: [Card] = []
    
    @Published var cardNamesResults: CardNamesResult?
    @Published var cardNamesStrings: [String] = []
    @Published var cardImageUrl: String?
    
    @Published var loading: Bool = false
    
    // MARK: Init
    init(interactor: SearchScreenInteractor) {
        self.interactor = interactor
    }
    
    //MARK: Get card by partial name
    @MainActor func getCard(cardName: String) async {
        loading = true
        
        cardsByName.removeAll()
        
        Task {
            do {
                if cardName.count >= 3 {
                    cardsByName = try await interactor.getCard(cardName: cardName) ?? []
                }
                
                loading = false
            } catch {
                print("Error getting card by name")
                
                loading = false
            }
        }
    }
    
    // MARK: Get cards list by partial name
    @MainActor func getCards(cardName: String) async {
        loading = true
        
        cardNamesStrings.removeAll()
        
        Task {
            do {
                if cardName.count >= 3 {
                    cardNamesResults = try await interactor.getCardsNames(partialCardName: cardName)
                    
                    guard let cardsNamesResults = cardNamesResults else {
                        loading = false
                        
                        return
                    }
                    
                    cardNamesStrings = cardsNamesResults.cardsNames
                    
                    loading = false
                }
            } catch {
                loading = false
                
                print("Error getting cards by name")
            }
        }
    }
}

extension SearchScreenVM {
    static var testVM = SearchScreenVM(interactor: .test)
}
