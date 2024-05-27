//
//  FavouritesCardsVM.swift
//  MTGCardScan
//
//  Created by Carlos Gutiérrez Casado on 22/5/24.
//

import SwiftUI

class FavouritesCardsVM: ObservableObject {
    private var interactor = FavouritesCardsInteractor()
    
    @Published var favCards: [Card] = []
    
    // MARK: Init
    init(interactor: FavouritesCardsInteractor) {
        self.interactor = interactor
    }
    
    //MARK: Get cards historial
    @MainActor func getCardHistorial() async {
        do {
            favCards = try await interactor.getFavCards()
        } catch {
            print("Error getting cards historial")
        }
        
    }
}
