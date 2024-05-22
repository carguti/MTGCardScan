//
//  CardsHistorialView.swift
//  MTGCardScan
//
//  Created by Carlos Gutiérrez Casado on 22/5/24.
//

import SwiftUI

struct CardsHistorialView: View {
    @StateObject var searchResultVM: SearchResultVM
    
    private let adaptiveColumn = [
        GridItem(.fixed(150)),
        GridItem(.fixed(150))
    ]
    
    @State private var resultsMode = ResultsMode.list
    
    private enum ResultsMode {
        case list, grid
        
        func icon() -> String {
            switch self {
            case .list:
                return "rectangle.3.offgrid.fill"
            case .grid:
                return "rectangle.grid.1x2"
            }
        }
    }
    
    var body: some View {
        ScrollView {
            Text("Historial")
                .font(.system(size: 28).bold())
                .foregroundColor(Color(uiColor: .white))
                .multilineTextAlignment(.center)
            
            resultsView
        }
        .hiddenNavigationBarStyle()
        .navigationBarHidden(true)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(uiColor: .darkGray))
        .padding(.horizontal, 0)
        .padding(.top, 60)
    }
    
    // MARK: searchFields view
    private var resultsView: some View {
        VStack {
            Button(action: {
                resultsMode = resultsMode == .grid ? .list : .grid
            }) {
                HStack {
                    Image(systemName: resultsMode.icon()).imageScale(.medium)
                        .foregroundColor(.white)
                }
                .frame(width: 32, height: 32)
            }
            
            if resultsMode == .grid {
                ScrollView{
                    LazyVGrid(columns: adaptiveColumn, spacing: 20) {
                        ForEach(UserDefaults.standard.cardsHistorial, id: \.self) { card in
                            NavigationLink(destination: SearchResultView(searchResultVM: searchResultVM, card: card)) {
                                CardGridCell(card: card)
                                    .listRowBackground(Color.clear)
                            }
                            .listRowBackground(Color.clear)
                            .foregroundColor(.clear)
                            .background(.clear)
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    
                    Spacer()
                }
            } else {
                VStack {
                    ForEach(UserDefaults.standard.cardsHistorial, id: \.self) { card in
                        NavigationLink(destination: SearchResultView(searchResultVM: searchResultVM, card: card)) {
                            CardListCell(card: card)
                                .listRowBackground(Color.clear)
                        }
                        .listRowBackground(Color.clear)
                        .foregroundColor(.clear)
                        .background(.clear)
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                    Spacer()
                }
                .padding()
                
                Spacer()
            }
        }
        
    }
}
