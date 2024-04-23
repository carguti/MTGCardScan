//
//  NavBar+Utils.swift
//  MTGCardScan
//
//  Created by Carlos Gutiérrez Casado on 23/4/24.
//

import SwiftUI

struct HiddenNavigationBar: ViewModifier {
    func body(content: Content) -> some View {
       content
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
    }
}

extension View {
    func hiddenNavigationBarStyle() -> some View {
        modifier(HiddenNavigationBar())
    }
}
