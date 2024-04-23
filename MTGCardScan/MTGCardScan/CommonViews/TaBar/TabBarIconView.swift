//
//  TabBarIconView.swift
//  MTGCardScan
//
//  Created by Carlos Gutiérrez Casado on 23/4/24.
//

import SwiftUI

struct TabBarIconView<Tab: TabBarItem & CaseIterable>: View {
    let tab: Tab
    let selected: Bool
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            VStack(spacing: 0) {
                Rectangle()
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity)
                    .frame(height: 4)
                    .opacity(selected ? 1.0 : 0.0)
                    .shadow(color: .black.opacity(0.3),
                            radius: 1, x: 0, y: -1)
                
                tab.icon
                    .renderingMode(.template)
                    .resizable()
                    .foregroundColor(.gray)
                    .animation(.spring(), value: selected)
                    .frame(width: tab.iconSize.width, height: tab.iconSize.height)
                    .padding(.top, 10)
                    .offset(y: 0)
                
                Text(tab.title)
                    .font(.system(size: 12).bold())
                    .foregroundColor(.gray)
                    .padding(.top, 3)
                
                Spacer()
            }
        }
        .frame(maxWidth: .infinity)
        .frame(maxHeight: .infinity)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarIconView(tab: MainTab.scanView, selected: false)
        TabBarIconView(tab: MainTab.searchView, selected: true)
        TabBarIconView(tab: MainTab.historialView, selected: false)
        TabBarIconView(tab: MainTab.favouritesView, selected: false)
    }
}
