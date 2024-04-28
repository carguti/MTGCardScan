//
//  SearchScreenVM.swift
//  MTGCardScan
//
//  Created by Carlos Gutiérrez Casado on 27/4/24.
//

import SwiftUI

class SearchScreenVM: ObservableObject {
    private var interactor = SearchScreenInteractor()
    
    @Published var cardNamesResults: CardNamesResult?
    @Published var cardNamesStrings: [String] = []
    
    // MARK: Init
    init(interactor: SearchScreenInteractor) {
        self.interactor = interactor
    }
    
    @MainActor func gerCards(cardName: String) async {
        cardNamesStrings.removeAll()
        
        Task {
            do {
                if cardName.count >= 3 {
                    cardNamesResults = try await interactor.getCardsNames(partialCardName: cardName)
                    
                    guard let cardsNamesResults = cardNamesResults else {
                        return
                    }
                    
                    cardNamesStrings = cardsNamesResults.cardsNames
                }
            } catch {
                print("Error getting cards by name")
            }
        }
    }
}

extension SearchScreenVM {
    static var testVM = SearchScreenVM(interactor: .test)
}
