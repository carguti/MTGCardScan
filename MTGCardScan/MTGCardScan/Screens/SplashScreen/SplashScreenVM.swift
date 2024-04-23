//
//  SplashScreenVM.swift
//  MTGCardScan
//
//  Created by Carlos Gutiérrez Casado on 15/4/24.
//

import Foundation

final class SplashScreenVM: ObservableObject {
    // MARK: Pusblished properties
    @Published var splashScreenCompleted = false
    
    private let interactor = SplashScreenInteractor()
    
    @MainActor func initialSynch() async {
        Task {
            do {
                try await interactor.initialSynch()
                splashScreenCompleted = true
            } catch {
                print("Error doing initial synch")
            }
        }
        
    }
}
