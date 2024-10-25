//
//  CardTextField.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/25/24.
//

import SwiftUI

struct CardTextField: View {
    var label: String
    @Binding var value: String
    
    init(_ label: String, value: Binding<String>) {
        self.label = label
        self._value = value
    }
    
    var body: some View {
        HStack(alignment: .center) {
            HStack {
                Text(label)
                    .font(.system(size: 12, weight: .semibold))
                
                Spacer()
                
                TextField("", text: $value)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.trailing)
                    .frame(maxWidth: .infinity)
                    .textFieldStyle(.plain)
                    .overlay(Rectangle()
                        .frame(height: 1) // Thin underline
                        .foregroundColor(.gray.opacity(0.5)), // Line color
                             alignment: .bottom
                    )
            }
            .padding(2.5)
        }
    }
}