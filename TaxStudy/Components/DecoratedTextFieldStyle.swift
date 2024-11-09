//
//  DecoratedTextFieldStyle.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/28/24.
//

import SwiftUI

/// A custom `TextFieldStyle` that decorates a `TextField` with a symbol and additional styles.
struct DecoratedTextFieldStyle: TextFieldStyle {
    
    /// The symbol to display inside the `TextField`.
    var symbol: String
    
    /// Defines the body for the custom text field style, wrapping the text field with additional UI components.
    /// - Parameter configuration: The `TextField` configuration provided by SwiftUI.
    /// - Returns: A view that represents the decorated text field.
    func _body(configuration: TextField<_Label>) -> some View {
        HStack(spacing: 0) {
            HStack(alignment: .center, spacing: 0) {
                // Add the system symbol to the leading edge of the text field.
                Image(systemName: symbol)
                    .font(.system(size: 10, weight: .heavy, design: .rounded))
                    .foregroundStyle(.black.opacity(0.6))
            }
            .frame(maxWidth: 20, maxHeight: .infinity)  // Set the size of the symbol container.
            .padding(.horizontal, 2.5)  // Add horizontal padding around the symbol.
            .background(.gray.opacity(0.2))  // Set the background for the symbol container.
            
            // Add a vertical separator line between the symbol and the text field.
            Rectangle()
                .foregroundStyle(.black)
                .frame(maxWidth: 1, maxHeight: .infinity)
            
            // Configure the actual text field content.
            configuration
                .foregroundStyle(.black)
                .padding(.horizontal, 5)  // Add horizontal padding around the text field content.
                .padding(.vertical, 5)    // Add vertical padding around the text field content.
                .textFieldStyle(.plain)   // Use the plain text field style.
                .multilineTextAlignment(.trailing)  // Align text to the trailing edge.
        }
        .background(.white)  // Set the background color for the entire component.
        .clipShape(RoundedRectangle(cornerRadius: 5))  // Clip to a rounded rectangle.
        .background(
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color.black, lineWidth: 2)  // Add a black stroke around the rounded rectangle.
        )
        .frame(maxHeight: 30)  // Set a fixed height for the component.
    }
}

/// Extension on `TextField` to easily apply the `DecoratedTextFieldStyle` with a specific symbol.
extension TextField {
    
    /// Decorates the text field by applying the `DecoratedTextFieldStyle` with the given symbol.
    /// - Parameter symbol: The symbol to use for decoration.
    /// - Returns: A view that represents the decorated text field.
    func decorated(by symbol: String) -> some View {
        self.textFieldStyle(DecoratedTextFieldStyle(symbol: symbol))
    }
}

#Preview {
    @Previewable @State var moneyValue = 220250.23
    @Previewable @State var rateValue = 0.225
    @Previewable @State var ageValue = 52
    @Previewable @State var nameValue = "Tax Payer 1"
    
    VStack {
        // Example usage of the decorated text fields with different symbols.
        TextField("Amount", value: $moneyValue, format: .number)
            .decorated(by: "dollarsign")
        TextField("Amount", value: $rateValue, format: .percent)
            .decorated(by: "percent")
        TextField("Amount", value: $ageValue, format: .number)
            .decorated(by: "number")
        TextField("Amount", text: $nameValue)
            .decorated(by: "person")
        Spacer()
    }
    .padding()
}
