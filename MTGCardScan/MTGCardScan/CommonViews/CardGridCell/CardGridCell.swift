//
//  CardGridCell.swift
//  MTGCardScan
//
//  Created by Carlos Gutiérrez Casado on 9/5/24.
//

import SwiftUI

struct CardGridCell: View {
    let card: Card?
    
    let secondaryColor = Color(uiColor: UIColor(red: 255/255, green: 173/255, blue: 1/255, alpha: 1))
    
    @State var flipped = false
    
    var body: some View {
        ZStack {
            VStack(spacing: 2) {
                if let cardFace = card?.cardFaces {
                    if cardFace.first?.imagesUris != nil {
                        ZStack {
                            AsyncImage(url: URL(string: cardFace.first?.imagesUris != nil ? cardFace.first?.imagesUris?.normal ?? "" : card?.imageUris?.normal ?? "")) { image in
                                image.resizable()
                            } placeholder: {
                                Color.black
                            }
                            .frame(width: 156, height: 216)
                            .clipShape(.rect(cornerRadius: 12))
                            .opacity(flipped ? 0.0 : 1.0)
                            
                            AsyncImage(url: URL(string: cardFace.last?.imagesUris?.normal ?? "")) { image in
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
                                    .resizable()
                                    .frame(width: 22, height: 22)
                                    .foregroundColor(secondaryColor)
                                    .cornerRadius(4.0)
                            })
                            .frame(width: 26, height: 26)
                            .buttonStyle(.bordered)
                            .background(Color(uiColor: .gray).opacity(0.8))
                            .padding(.bottom, 6)
                            .cornerRadius(6)
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
