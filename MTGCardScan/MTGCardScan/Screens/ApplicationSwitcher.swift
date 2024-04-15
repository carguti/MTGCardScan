//
//  ApplicationSwitcher.swift
//  MTGCardScan
//
//  Created by Carlos Gutiérrez Casado on 15/4/24.
//

import SwiftUI

struct ApplicationSwitcher: View {
    var body: some View {
        if !UserDefaults.standard.onBoardingShown {
            //OnboardingView()
        } else {
            //ScanCardView()
        }
    }
}

#Preview {
    ApplicationSwitcher()
}
