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
    let foregroundSelectedColor = Color(uiColor: UIColor(red: 255/255, green: 173/255, blue: 1/255, alpha: 1))
    let foreGroundNoSelectedColor = Color(uiColor: .lightGray)
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            VStack(spacing: 0) {
                Capsule()
                    .fill(foregroundSelectedColor.opacity(0.8))
                    .frame(width: tab.iconSize.width * 3, height: tab.iconSize.height + 12)
                    .animation(.spring(), value: selected)
                    .opacity(selected ? 0.5 : 0.0)
                    .padding(.top, 4)
                    .overlay(
                        tab.icon
                            .renderingMode(.template)
                            .resizable()
                            .foregroundColor(selected ? foregroundSelectedColor : foreGroundNoSelectedColor)
                            .animation(.spring(), value: selected)
                            .frame(width: tab.iconSize.width, height: tab.iconSize.height)
                            .padding(.top, 4)
                            .offset(y: 0)
                    )
                
                Text(tab.title)
                    .font(.system(size: 12).bold())
                    .foregroundColor(selected ? foregroundSelectedColor : foreGroundNoSelectedColor)
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
        TabBarIconView(tab: MainTab.searchView, selected: true)
        TabBarIconView(tab: MainTab.historialView, selected: false)
        TabBarIconView(tab: MainTab.favouritesView, selected: false)
    }
}
