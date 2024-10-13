//
//  MetaCard.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/13/24.
//

import SwiftUI

struct MetaCard: View {
    var symbolName: String
    var label: String
    var value: String
    
    var body: some View {
        HStack {
            Rectangle()
                            .fill(Color.blue.opacity(0.6)) // Lighter blue color
                            .frame(width: 5) //
            // Circle with the symbol inside
            ZStack {
                Circle()
                    .stroke(lineWidth: 2)
                    .foregroundColor(.primary)
                    .frame(width: 35, height: 35)
                
                Image(systemName: symbolName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.accentSecondary)
            }
            
            VStack(alignment: .leading) {
                // Title "Filing Status"
                Text(label)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                // Enum string value
                Text(value)
                    .textCase(.uppercase)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
            }
            .padding(.leading, 10)
            .padding(.trailing, 10)
            .padding(.top, 15)
            .padding(.bottom, 15)
        }
        .background(Color.altBackground)
        .cornerRadius(5)
    }
}

struct FilingStatusView_Previews: PreviewProvider {
    static var previews: some View {
        MetaCard(symbolName: FilingStatus.single.symbol, label: "Filing Status", value: FilingStatus.single.rawValue)
            .previewLayout(.sizeThatFits)
//            .padding()
    }
}
