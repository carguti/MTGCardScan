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
    
    @MainActor func initialSynch() async {
        splashScreenCompleted = true
    }
}
