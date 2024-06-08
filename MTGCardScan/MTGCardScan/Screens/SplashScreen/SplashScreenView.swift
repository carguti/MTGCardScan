//
//  SplashScreenView.swift
//  MTGCardScan
//
//  Created by Carlos Gutiérrez Casado on 15/4/24.
//

import SwiftUI

struct SplashScreenView: View {
    @StateObject var splasScreenVM = SplashScreenVM()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Text("SplashScreen")
            }
            
            NavigationLink(destination: ApplicationSwitcher(), isActive: $splasScreenVM.splashScreenCompleted) {
                EmptyView()
            }
        }
        .onAppear {
            Task {
                await splasScreenVM.initialSynch()
            }
        }
        .overlay {
            LoadingView()
                .opacity(splasScreenVM.loading ? 1.0 : 0.0)
        }
    }
}

#Preview {
    SplashScreenView()
}
