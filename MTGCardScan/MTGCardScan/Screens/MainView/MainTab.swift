//
//  MainTab.swift
//  MTGCardScan
//
//  Created by Carlos Gutiérrez Casado on 23/4/24.
//

import SwiftUI

enum MainTab {
    case searchView
    case historialView
    case favouritesView
}

// MARK: CaseIterable

extension MainTab: CaseIterable { }

// MARK: TabBarItem

extension MainTab: TabBarItem {
    var icon: Image {
        switch self {
        case .searchView:
            return Image(systemName: "text.magnifyingglass")
        case .historialView:
            return Image(systemName: "clock")
        case .favouritesView:
            return Image(systemName: "star")
        }
    }
    
    var title: String {
        switch self {
        case .searchView:
            return "TAB_BAR_SEARCH".localized
        case .historialView:
            return "TAB_BAR_HISTORIAL".localized
        case .favouritesView:
            return "TAB_BAR_FAVS".localized
        }
    }
    
    var iconSize: CGSize {
        switch self {
        case .searchView:
            return CGSize(width: 24, height: 24)
        case .historialView:
            return CGSize(width: 24, height: 24)
        case .favouritesView:
            return CGSize(width: 24, height: 24)
        }
    }
}
