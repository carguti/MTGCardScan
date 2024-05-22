//
//  CardListCell.swift
//  MTGCardScan
//
//  Created by Carlos Gutiérrez Casado on 28/4/24.
//

import SwiftUI

struct CardListCell: View {
    let card: Card?
    
    var body: some View {
        ZStack {
            HStack {
                AsyncImage(url: URL(string: card?.imageUris?.normal ?? "")) { image in
                    image.resizable()
                } placeholder: {
                    Color.black
                }
                .frame(width: 156, height: 216)
                .clipShape(.rect(cornerRadius: 12))
                
                Text(card?.name ?? "-")
                    .font(.system(size: 16))
                    .padding()
                    .foregroundColor(.white)
                    .background(.clear)
                
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

