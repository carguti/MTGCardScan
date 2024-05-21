//
//  MainView.swift
//  MTGCardScan
//
//  Created by Carlos Gutiérrez Casado on 23/4/24.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var mainTabBarManager = TabBarManager<MainTab>()
    
    @StateObject var searchScreenVM = SearchScreenVM(interactor: SearchScreenInteractor())
    @StateObject var searchResultVM = SearchResultVM(interactor: SearchResultInteractor())
    
    @State var tabOptionPressed: Int = 0
    @State var destinationViewTitle: String = ""
    
    var body: some View {
        content
            .hiddenNavigationBarStyle()
    }
    
    // MARK: Content view
    private var content: some View {
        ZStack {
            VStack(spacing: 0) {
                if mainTabBarManager.currentTab != nil {
                    getView(tab: mainTabBarManager.currentTab!)
                        .frame(maxHeight: .infinity)
                }
            }
            
            VStack(spacing: 0) {
                Spacer()
                
                TabBarView(tabBarManager: mainTabBarManager, tabOptionPressed: $tabOptionPressed, destinationViewTitle: $destinationViewTitle)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .ignoresSafeArea()
    }
    
    // MARK: Get view from TabBar option selected
    @ViewBuilder
    private func getView(tab: MainTab) -> some View {
        switch tab {
        case .scanView:
            ScanCardView()
        case .searchView:
            SearchScreenView(searchScreenVM: searchScreenVM, searchResultVM: searchResultVM)
        case .historialView:
            EmptyView()
        case .favouritesView:
            EmptyView()
        }
    }
}

#Preview {
    MainView(searchScreenVM: .testVM)
}
