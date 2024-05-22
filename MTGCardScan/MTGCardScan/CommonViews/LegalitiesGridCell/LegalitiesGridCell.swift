//
//  LegalitiesGridCell.swift
//  MTGCardScan
//
//  Created by Carlos Gutiérrez Casado on 19/5/24.
//

import SwiftUI

struct LegalitiesGridCell: View {
    let legalityName: String
    let legalValue: String
    
    var body: some View {
        HStack() {
            Text(legalityName)
                .font(.system(size: 16).bold())
                .foregroundColor(.white)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity)
            
            Text(legalValue == "legal" ? "Legal" : "No legal")
                .padding(10)
                .font(.system(size: 16).bold())
                .foregroundColor(.white)
                .multilineTextAlignment(.trailing)
                .background(legalValue == "legal" ? .green : .red)
                .clipShape(RoundedRectangle(cornerRadius: 8.0))
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity)
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        
    }
}

#Preview {
    LegalitiesGridCell(legalityName: "Pioneer", legalValue: "legal")
}
