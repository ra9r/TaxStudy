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
                    .decorated(by: "dollarsign")
                    .frame(maxWidth: 150)
            }
            .padding(2.5)
        }
    }
}

