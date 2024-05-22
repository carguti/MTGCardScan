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
    
    // MARK: Init
    init(interactor: SearchResultInteractor) {
        self.interactor = interactor
    }
    
    // MARK: Get card prints
    @MainActor func getCardPrints(printsUri: String) async {
        cardPrints.removeAll()
        
        Task {
            do {
                cardPrints = try await interactor.getCardPrints(printsUri: printsUri) ?? []
            } catch {
                print("Error getting card prints")
            }
        }
    }
}

extension SearchResultVM {
    static var testVM = SearchResultVM(interactor: .test)
}

