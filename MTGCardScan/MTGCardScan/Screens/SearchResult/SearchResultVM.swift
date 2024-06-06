//
//  SearchResultVM.swift
//  MTGCardScan
//
//  Created by Carlos Gutiérrez Casado on 15/5/24.
//

import SwiftUI

class SearchResultVM: ObservableObject {
    private var interactor = SearchResultInteractor()
    
    @Published var cardPrints: [CardPrintsInfo] = []
    @Published var selectedCard: Card?
    
    // MARK: Init
    init(interactor: SearchResultInteractor) {
        self.interactor = interactor
    }
    
    // MARK: - Store selected card
    @MainActor func storeSelectedCard(card: Card) async {
        Task {
            do {
                try await interactor.storeSelectedCard(card: card)
            } catch {
                print("Error setting selected card")
            }
        }
    }
    
    // MARK: - Get selected card
    @MainActor func getSelectedCard() async {
        Task {
            do {
                selectedCard = try await interactor.getSelectedCard()
            } catch {
                print("Error getting selected card")
            }
        }
    }
    
    // MARK: Get card prints
    @MainActor func getCardPrints(printsUri: String) async {
        cardPrints.removeAll()
        
        Task {
            do {
                cardPrints = try await interactor.getCardPrints(printsUri: printsUri) ?? []
                
                var i = 0
            } catch {
                print("Error getting card prints")
            }
        }
    }
}

extension SearchResultVM {
    static var testVM = SearchResultVM(interactor: .test)
}

