//
//  CardGridCell.swift
//  MTGCardScan
//
//  Created by Carlos Gutiérrez Casado on 9/5/24.
//

import SwiftUI

struct CardGridCell: View {
    let card: Card?
    
    var body: some View {
        ZStack {
            VStack(spacing: 2) {
                AsyncImage(url: URL(string: card?.imageUris?.normal ?? "")) { image in
                    image.resizable()
                } placeholder: {
                    Color.black
                }
                .frame(width: 156, height: 216)
                .clipShape(.rect(cornerRadius: 12))
                
                Text(card?.name ?? "-")
                    .font(.system(size: 14))
                    .padding()
                    .foregroundColor(.white)
                    .background(.clear)
                    .multilineTextAlignment(.center)
                
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
