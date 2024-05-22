//
//  SearchScreenView.swift
//  MTGCardScan
//
//  Created by Carlos Gutiérrez Casado on 27/4/24.
//

import SwiftUI

struct SearchScreenView: View {
    @StateObject var searchScreenVM: SearchScreenVM
    @StateObject var searchResultVM: SearchResultVM
    
    @State private var cardName = ""
    var cardNames: [String] = []
    var cardImagesUrls: [String] = []
    
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
        ZStack {
            VStack {
                searchView
                
                resultsView
                    .opacity(searchScreenVM.cardsByName.count > 0 ? 1 : 0)
                
                Spacer()
            }
            .hiddenNavigationBarStyle()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal, 0)
            .padding(.top, 40)
            .padding(.bottom, 20)
        }
        .background(Color(uiColor: .darkGray))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
        .hiddenNavigationBarStyle()
        .navigationBarBackButtonHidden(true)
    }
    
    // MARK: searchFields view
    private var searchView: some View {
        ZStack(alignment: .leading) {
            VStack(spacing: 20) {
                Text("SEARCH_CARDS_BY_NAME".localized)
                    .font(.system(size: 28).bold())
                    .foregroundColor(Color(uiColor: .white))
                
                HStack(spacing: 8) {
                    TextField("SEARCH_VIEW_PLACEHOLDER".localized, text: $cardName)
                        .foregroundColor(Color(uiColor: .white))
                    
                    Button {
                        cardName = ""
                    } label: {
                        Image(systemName: "multiply.circle.fill")
                    }
                    .opacity(cardName.count >= 3 ? 1 : 0)
                    .foregroundColor(.white)
                    .padding(.trailing, 4)
                }
                .frame(height: 32)
                .padding(.horizontal, 12)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.gray)
                )
                
                Button(action: {
                    Task {
                        await searchScreenVM.getCard(cardName: cardName)
                    }
                }, label: {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(Color(uiColor: .white))
                        
                        Text("SEARCH".localized)
                            .font(.system(size: 16).bold())
                            .foregroundColor(Color(uiColor: .white))
                    }
                    .frame(height: 46)
                    .padding(.horizontal, 12)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.gray)
                    )
                    
                })
                .opacity(cardName.count >= 3 ? 1 : 0)
            }
            
        }
        .padding(.top, 20)
        .padding(.horizontal, 20)
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
                        ForEach(searchScreenVM.cardsByName, id: \.self) { card in
                            CardGridCell(card: card)
                                .listRowBackground(Color.clear)
                        }
                    }
                    
                    Spacer()
                }
            } else {
                List {
                    ForEach(searchScreenVM.cardsByName, id: \.self) { card in
                        NavigationLink(destination: SearchResultView(searchResultVM: searchResultVM, card: card)) {
                            CardListCell(card: card)
                                .listRowBackground(Color.clear)
                        }
                        .listRowBackground(Color.clear)
                        .foregroundColor(.clear)
                        .background(.clear)
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .scrollContentBackground(.hidden)
                
                Spacer()
            }
        }
        
    }
}

#Preview {
    SearchScreenView(searchScreenVM: .testVM, searchResultVM: .testVM)
}
