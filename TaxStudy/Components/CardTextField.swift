//
//  CardTextField.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/25/24.
//

import SwiftUI

struct CardTextField: View {
    var label: String
    var symbol: String
    @Binding var value: String
    
    init(_ label: String, symbol: String, value: Binding<String>) {
        self.label = label
        self.symbol = symbol
        self._value = value
    }
    
    var body: some View {
        HStack(alignment: .center) {
            HStack {
                Text(label)
                    .font(.system(size: 12, weight: .semibold))
                
                Spacer()
                
                TextField("", text: $value)
                    .decorated(by: symbol)
            }
            .padding(2.5)
        }
    }
}
