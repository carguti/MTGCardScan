//
//  TabBarView.swift
//  MTGCardScan
//
//  Created by Carlos Gutiérrez Casado on 23/4/24.
//

import SwiftUI

typealias TabProtocol = Hashable & CaseIterable & TabBarItem

struct TabBarView<Tab: TabProtocol>: View where Tab.AllCases == Array<Tab> {
    
    //MARK: Variables
    @StateObject var tabBarManager: TabBarManager<Tab>
    @Binding var tabOptionPressed: Int
    @Binding var destinationViewTitle: String
    
    var body: some View {
        ZStack(alignment: .top) {
            HStack(spacing: 0) {
                let enumerated = Array(zip(tabBarManager.tabs.indices, tabBarManager.tabs))
                
                ForEach(enumerated, id: \.1) { index, tab in
                    TabBarIconView(tab: tab, selected: tab == tabBarManager.currentTab)
                        .onTapGesture {
                            DispatchQueue.main.async {
                                destinationViewTitle = ""
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1)  {
                                tabOptionPressed = index
                            }
                            
                            DispatchQueue.main.async {
                                tabBarManager.currentTab = tab
                            }
                        }
                    
                }
            }
        }
        .background(.clear)
        .ignoresSafeArea()
        .frame(height: Measures.kTabBarHeight)
        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: -1)
    }
}

#Preview {
    TabBarView(tabBarManager: TabBarManager<MainTab>(), tabOptionPressed: .constant(0), destinationViewTitle: .constant(""))
}
