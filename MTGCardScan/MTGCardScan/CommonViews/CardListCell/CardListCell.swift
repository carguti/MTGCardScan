//
//  CardListCell.swift
//  MTGCardScan
//
//  Created by Carlos Gutiérrez Casado on 28/4/24.
//

import SwiftUI

struct CardListCell: View {
    let card: Card?
    
    @State var flipped = false
    
    var body: some View {
        ZStack {
            HStack {
                if let cardFace = card?.cardFaces {
                    ZStack {
                        AsyncImage(url: URL(string: cardFace.first?.imagesUris.normal ?? "")) { image in
                            image.resizable()
                        } placeholder: {
                            Color.black
                        }
                        .frame(width: 156, height: 216)
                        .clipShape(.rect(cornerRadius: 12))
                        .opacity(flipped ? 0.0 : 1.0)
                        
                        AsyncImage(url: URL(string: cardFace.last?.imagesUris.normal ?? "")) { image in
                            image.resizable()
                        } placeholder: {
                            Color.black
                        }
                        .scaleEffect(x: -1, y: 1)
                        .frame(width: 156, height: 216)
                        .clipShape(.rect(cornerRadius: 12))
                        .opacity(flipped ? 1.0 : 0.0)
                    }
                    .overlay(alignment: .bottom) {
                        Button(action: {
                            self.flipped.toggle()
                        }, label: {
                            Image(systemName: "arrow.left.arrow.right")
                                .tint(Color(uiColor: .darkGray))
                                .cornerRadius(4.0)
                        })
                        .frame(width: 32, height: 32)
                        .buttonStyle(.bordered)
                        .background(Color(uiColor: .lightGray).opacity(0.5))
                    }
                    .rotation3DEffect(.degrees(flipped ? 180 : 0), axis: (x: 0, y: 1, z: 0))
                    .animation(.default, value: flipped)
                } else {
                    AsyncImage(url: URL(string: card?.imageUris?.normal ?? "")) { image in
                        image.resizable()
                    } placeholder: {
                        Color.black
                    }
                    .frame(width: 156, height: 216)
                    .clipShape(.rect(cornerRadius: 12))
                }
                
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

