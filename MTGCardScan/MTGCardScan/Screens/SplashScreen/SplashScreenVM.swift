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
    @Published var loading = false
    
    private let interactor = SplashScreenInteractor()
    
    @MainActor func initialSynch() async {
        loading = true
        Task {
            do {
                try await interactor.initialSynch()
                splashScreenCompleted = true
                loading = false
            } catch {
                loading = false
                
                print("Error doing initial synch")
            }
        }
        
    }
}
