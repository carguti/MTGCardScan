//
//  CardListCell.swift
//  MTGCardScan
//
//  Created by Carlos Gutiérrez Casado on 28/4/24.
//

import SwiftUI

struct CardListCell: View {
    let cardName: String
    
    var body: some View {
        Text(cardName)
            .font(.system(size: 18).bold())
            .padding()
            .foregroundColor(.white)
            .background(.clear)
    }
}

#Preview {
    CardListCell(cardName: "Edgar Markov")
}
