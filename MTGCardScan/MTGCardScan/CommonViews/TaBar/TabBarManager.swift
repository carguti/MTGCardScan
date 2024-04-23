//
//  TabBarManager.swift
//  MTGCardScan
//
//  Created by Carlos Gutiérrez Casado on 23/4/24.
//

import SwiftUI

protocol TabBarItem {
    var icon: Image { get }
    var title: String { get }
    var iconSize: CGSize { get }
}

// MARK: Tab bar manager


final class TabBarManager<Tab: TabBarItem & CaseIterable>: ObservableObject {
    @Published var tabs = Tab.allCases
    @Published var currentTab = Tab.allCases.first
}
