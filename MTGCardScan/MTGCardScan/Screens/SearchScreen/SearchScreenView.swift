//
//  SearchScreenView.swift
//  MTGCardScan
//
//  Created by Carlos Gutiérrez Casado on 27/4/24.
//

import SwiftUI

struct SearchScreenView: View {
    @StateObject var searchScreenVM: SearchScreenVM
    
    @State private var cardName = ""
    
    var body: some View {
        ZStack {
            VStack {
                searchView
                
                resultsView
                    .background(.clear)
                    .opacity(searchScreenVM.cardNamesStrings.count > 0 ? 1 : 0)
                
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
            HStack(spacing: 8) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(Color(uiColor: .white))
                
                TextField("SEARCH_VIEW_PLACEHOLDER".localized, text: $cardName)
                    .foregroundColor(Color(uiColor: .white))
                    .onChange(of: cardName) {
                        Task {
                            await searchScreenVM.gerCards(cardName: cardName)
                        }
                    }
                
            }
            .frame(height: 32)
            .padding(.horizontal, 12)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(.gray)
            )
        }
        .padding(.top, 20)
        .padding(.horizontal, 20)
    }
    
    // MARK: searchFields view
    private var resultsView: some View {
        List {
            ForEach(searchScreenVM.cardNamesStrings, id: \.self) { cardName in
                CardListCell(cardName: cardName)
                    .listRowBackground(Color.clear)
            }
        }
        .scrollContentBackground(.hidden)
    }
}

#Preview {
    SearchScreenView(searchScreenVM: .testVM)
}
