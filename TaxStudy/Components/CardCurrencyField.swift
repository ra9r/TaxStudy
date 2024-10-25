//
//  CurrencyField.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 9/30/24.
//

import SwiftUI

struct CardCurrencyField: View {
    var label: String
    @Binding var amount: Double
    
    init(_ label: String, amount: Binding<Double>) {
        self.label = label
        self._amount = amount
    }
    
    var body: some View {
        HStack(alignment: .center) {
            HStack {
                Text(label)
                    .font(.system(size: 12, weight: .semibold))
                
                Spacer()
                
                TextField("Amount", value: $amount, format: .number)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.trailing)
                    .frame(maxWidth: .infinity)
                    .textFieldStyle(.plain)
            }
            .padding(2.5)
        }
    }
}

