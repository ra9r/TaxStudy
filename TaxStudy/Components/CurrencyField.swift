//
//  CurrencyField.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 9/30/24.
//

import SwiftUI

struct CurrencyField: View {
    var title: String
    @Binding var amount: Double
    
    var body: some View {
        HStack(alignment: .center) {
            Text(title)
            Spacer()
            TextField("Enter amount", value: $amount, format: .currency(code: "USD"))
                .multilineTextAlignment(.trailing)
                .frame(width: 100)
        }
    }
}
