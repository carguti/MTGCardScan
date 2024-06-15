//
//  CardPrintsCell.swift
//  MTGCardScan
//
//  Created by Carlos Gutiérrez Casado on 15/5/24.
//

import SwiftUI

struct CardPrintsCell: View {
    let cardPrintInfo: CardPrintsInfo?
    
    @Environment(\.openURL) private var openURL
    
    @State var flipped = false
    
    let titleColor = Color(uiColor: UIColor(red: 255/255, green: 173/255, blue: 1/255, alpha: 1))
    
    var body: some View {
        ZStack {
            HStack {
                if let cardFace = cardPrintInfo?.cardFaces {
                    if cardFace.first?.imagesUris != nil {
                        ZStack {
                            AsyncImage(url: URL(string: cardPrintInfo?.cardFaces?.first?.imagesUris != nil ? cardFace.first?.imagesUris?.normal ?? "" : cardPrintInfo?.imageUris?.normal ?? "")) { image in
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
                                    .foregroundColor(titleColor)
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
                        AsyncImage(url: URL(string: cardPrintInfo?.imageUris?.normal ?? "")) { image in
                            image.resizable()
                        } placeholder: {
                            Color.black
                        }
                        .frame(width: 156, height: 216)
                        .clipShape(.rect(cornerRadius: 12))
                    }
                } else {
                    AsyncImage(url: URL(string: cardPrintInfo?.imageUris?.normal ?? "")) { image in
                        image.resizable()
                    } placeholder: {
                        Color.black
                    }
                    .frame(width: 156, height: 216)
                    .clipShape(.rect(cornerRadius: 12))
                }
                
                
                VStack(spacing: 2) {
                    Text(cardPrintInfo?.setName ?? "-")
                        .multilineTextAlignment(.center)
                        .font(.system(size: 16, weight: .bold))
                        .padding()
                        .foregroundColor(Color(titleColor))
                        .background(.clear)
                    
                    
                    HStack(spacing: 0) {
                        VStack {
                            Text("No Foil")
                                .multilineTextAlignment(.leading)
                                .font(.system(size: 12, weight: .bold))
                                .padding()
                                .foregroundColor(Color(.lightGray))
                                .background(.clear)
                            
                            Text("Foil")
                                .multilineTextAlignment(.leading)
                                .font(.system(size: 12, weight: .bold))
                                .padding()
                                .foregroundColor(Color(.lightGray))
                                .background(.clear)
                            
                            Spacer()
                        }
                        
                        VStack {
                            Text((cardPrintInfo?.prices.euro ?? "-") + "€" )
                                .multilineTextAlignment(.trailing)
                                .font(.system(size: 12, weight: .bold))
                                .padding()
                                .foregroundColor(.white)
                                .background(.clear)
                            
                            Text((cardPrintInfo?.prices.euroFoil ?? "-") + "€" )
                                .multilineTextAlignment(.trailing)
                                .font(.system(size: 12, weight: .bold))
                                .padding()
                                .foregroundColor(.white)
                                .background(.clear)
                            
                            Spacer()
                        }
                    }
                    
                    VStack {
                        Button {
                            if let url = URL(string: (cardPrintInfo?.purchaseUris?.cardmarket)!) {
                                openURL(url) { accepted in
                                    print(accepted ? "Success" : "Failure")
                                }
                            }
                        } label: {
                            Text("Comprar en Cardmarket")
                                .multilineTextAlignment(.center)
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(Color(titleColor))
                                .background(.clear)
                        }
                    }
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    func handleURL(_ url: URL) -> OpenURLAction.Result {
        return .handled
    }
}
