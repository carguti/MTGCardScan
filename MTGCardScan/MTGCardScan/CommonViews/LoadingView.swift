//
//  LoadingView.swift
//  MTGCardScan
//
//  Created by Carlos Gutiérrez Casado on 8/6/24.
//

import SwiftUI

struct LoadingView: View {
    
    let message: String?
    var body: some View {
        Rectangle()
            .fill(.ultraThinMaterial)
            .background(Color(uiColor: .black).opacity(0.3))
            .overlay {
                ProgressView(message ?? "")
                    .progressViewStyle(
                        CircularProgressViewStyle(tint: .gray)
                    )
                    .foregroundColor(.gray)
            }
            .ignoresSafeArea()
    }
    
    init(message: String? = nil) {
        self.message = message
    }
}
 
struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(message: "LOADING".localized)
    }
}
