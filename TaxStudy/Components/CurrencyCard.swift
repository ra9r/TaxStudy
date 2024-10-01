//
//  Untitled.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 9/30/24.
//

import SwiftUI

struct CurrencyCard: View {
    var title: String
    var value: Double
    
    func format(_ value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyAccounting
        formatter.maximumFractionDigits = 0 // No decimals
        formatter.minimumFractionDigits = 0 // No decimals
        return formatter.string(from: NSNumber(value: value)) ?? "$0.00"
    }

    var body: some View {
        GroupBox {
            VStack {
                Text(title)
                Text(format(value))
                    .font(.largeTitle)
            }
            .padding()
        }
    }
}
