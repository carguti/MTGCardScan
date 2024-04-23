//
//  SplashScreenInteractor.swift
//  MTGCardScan
//
//  Created by Carlos Gutiérrez Casado on 15/4/24.
//

import Foundation

final class SplashScreenInteractor {
    func initialSynch() async throws {
        Dependencies.shared.provideDependencies()
    }
}
