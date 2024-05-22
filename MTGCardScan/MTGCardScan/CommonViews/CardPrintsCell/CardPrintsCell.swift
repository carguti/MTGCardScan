//
//  CardPrintsCell.swift
//  MTGCardScan
//
//  Created by Carlos Gutiérrez Casado on 15/5/24.
//

import SwiftUI

struct CardPrintsCell: View {
    let cardPrintInfo: CardPrintsInfo?
    
    var body: some View {
        ZStack {
            HStack {
                AsyncImage(url: URL(string: cardPrintInfo?.imageUris.normal ?? "")) { image in
                    image.resizable()
                } placeholder: {
                    Color.black
                }
                .frame(width: 156, height: 216)
                .clipShape(.rect(cornerRadius: 12))
                
                VStack(spacing: 4) {
                    Text(cardPrintInfo?.setName ?? "-")
                        .font(.system(size: 12))
                        .padding()
                        .foregroundColor(.white)
                        .background(.clear)
                    
                    HStack(spacing: 4) {
                        Text("Normal")
                            .font(.system(size: 14))
                            .padding()
                            .foregroundColor(.white)
                            .background(.clear)
                        
                        Text((cardPrintInfo?.prices.euro ?? "-") + "€" )
                            .font(.system(size: 14))
                            .padding()
                            .foregroundColor(.white)
                            .background(.clear)
                        
                        Spacer()
                    }
                    
                    HStack(spacing: 4) {
                        Text("Foil")
                            .font(.system(size: 14))
                            .padding()
                            .foregroundColor(.white)
                            .background(.clear)
                        
                        Text((cardPrintInfo?.prices.euroFoil ?? "-") + "€" )
                            .font(.system(size: 14))
                            .padding()
                            .foregroundColor(.white)
                            .background(.clear)
                        
                        Spacer()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
