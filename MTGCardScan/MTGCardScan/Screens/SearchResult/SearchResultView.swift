//
//  SearchResultView.swift
//  MTGCardScan
//
//  Created by Carlos Gutiérrez Casado on 10/5/24.
//

import SwiftUI

struct SearchResultView: View {
    @StateObject var searchResultVM: SearchResultVM
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var card: Card
    let foregroundSelectedColor = Color(uiColor: UIColor(red: 255/255, green: 173/255, blue: 1/255, alpha: 1))
    
    @State private var isFav = false
    @State private var showPrices = true
    @State private var showLegality = false
    @State private var showCardImagePopUp = false
    
    var body: some View {
        ScrollView {
            nameAndFavView
            
            AsyncImage(url: URL(string: card.imageUris?.large ?? "")) { image in
                image.resizable()
            } placeholder: {
                Color.black
            }
            .frame(width: 312, height: 432)
            .clipShape(.rect(cornerRadius: 16))
            
            pricesLegalityView
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .onAppear(perform: {
                    Task {
                        await searchResultVM.getCardPrints(printsUri: card.printsSearchUri)
                    }
                })
            
            Spacer()
        }
        .navigationBarHidden(true)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(uiColor: .darkGray))
        .sheet(isPresented: $showCardImagePopUp, content: {
            VStack {
                Text(UserDefaults.standard.selectedCardEdition)
                    .font(.system(size: 22).bold())
                    .foregroundColor(Color(uiColor: .white))
                    .multilineTextAlignment(.center)
                
                AsyncImage(url: URL(string: UserDefaults.standard.selectedCardImageUri)) { image in
                    image.resizable()
                } placeholder: {
                    Color.black
                }
                .frame(width: 312, height: 432)
                .clipShape(.rect(cornerRadius: 16))
                .presentationDetents([.large])
                .presentationBackground(.ultraThinMaterial)
            }
            .padding(.top, 26)
            
        })
        .onAppear {
            if !UserDefaults.standard.cardsHistorial.contains(card) {
                UserDefaults.standard.cardsHistorial.append(card)
            }
        }
        
    }
    
    // MARK: nameAndFavView view
    private var nameAndFavView: some View {
        HStack {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "chevron.left")
                    .resizable()
                    .foregroundColor(foregroundSelectedColor)
                    .frame(width: 16)
            })
            
            Spacer()
            
            Text(card.name)
                .font(.system(size: 22).bold())
                .foregroundColor(Color(uiColor: .white))
                .multilineTextAlignment(.center)
            
            
            
            Spacer()
            
            Button(action: {
                isFav = !isFav
            }, label: {
                Image(systemName: isFav ? "star.fill" : "star")
                    .resizable()
                    .foregroundColor(Color(uiColor: UIColor(red: 255/255, green: 173/255, blue: 1/255, alpha: 1)))
                    .frame(width: 36, height: 36)
            })
            
            Spacer()
        }
        .padding(.horizontal, 26)
        .frame(maxWidth: .infinity)
    }
    
    // MARK: Prives and legality view
    private var pricesLegalityView: some View {
        VStack {
            HStack {
                Button(action: {
                    showPrices = true
                    showLegality = false
                }, label: {
                    Capsule()
                        .fill(foregroundSelectedColor.opacity(0.8))
                        .frame(width: 124, height: 42)
                        .animation(.spring(), value: showPrices)
                        .opacity(showPrices ? 0.5 : 0.0)
                        .padding()
                        .overlay(
                            Text("RESULT_PRICES_TITLE".localized)
                                .font(.system(size: 18).bold())
                                .foregroundColor(showPrices ? Color(uiColor: .darkGray) : foregroundSelectedColor)
                                .multilineTextAlignment(.center)
                        )
                })
                .buttonStyle(.bordered)
                .tint(.clear)
                
                Button(action: {
                    showPrices = false
                    showLegality = true
                }, label: {
                    Capsule()
                        .fill(foregroundSelectedColor.opacity(0.8))
                        .frame(width: 124, height: 42)
                        .animation(.spring(), value: showLegality)
                        .opacity(showLegality ? 0.5 : 0.0)
                        .padding()
                        .overlay(
                            Text("RESULT_LEGALITY_TITLE".localized)
                                .font(.system(size: 18).bold())
                                .foregroundColor(showLegality ? Color(uiColor: .darkGray) : foregroundSelectedColor)
                                .multilineTextAlignment(.center)
                        )
                })
                .buttonStyle(.bordered)
                .tint(.clear)
            }
            
            if showPrices {
                pricesView
                    .padding(.horizontal, 20)
            } else {
                legalityView
                    .padding(.horizontal, 20)
            }
            
            
            Spacer()
        }
    }
    
    // MARK: Prices view
    private var pricesView: some View {
        VStack {
            ForEach(searchResultVM.cardPrints, id: \.self) { cardPrintInfo in
                CardPrintsCell(cardPrintInfo: cardPrintInfo)
                    .listRowBackground(Color.clear)
                    .onTapGesture {
                        UserDefaults.standard.selectedCardImageUri = cardPrintInfo.imageUris.large
                        UserDefaults.standard.selectedCardEdition = cardPrintInfo.setName
                        showCardImagePopUp = true
                    }
            }
            
            Spacer()
        }
        .padding()
    }
    
    // MARK: Legality view
    private var legalityView: some View {
        Grid {
            // Standard - Modern
            GridRow {
                LegalitiesGridCell(legalityName: "Standard", legalValue: card.legalities.standard)
                LegalitiesGridCell(legalityName: "Modern", legalValue: card.legalities.modern)
            }
            
            // Legacy - Commander
            GridRow {
                LegalitiesGridCell(legalityName: "Legacy", legalValue: card.legalities.legacy)
                LegalitiesGridCell(legalityName: "Commander", legalValue: card.legalities.commander)
            }
            
            // Pioneer - Pauper
            GridRow {
                LegalitiesGridCell(legalityName: "Pioneer", legalValue: card.legalities.pioneer)
                LegalitiesGridCell(legalityName: "Pauper", legalValue: card.legalities.pauper)
            }
        }
        .padding()
    }

}
