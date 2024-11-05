//
//  DecoratedTextItemStyle.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/28/24.
//
import SwiftUI

struct DecoratedTextItemStyle : ViewModifier {
    /// The symbol to display inside the `TextField`.
    var symbol: String

    func body(content: Content) -> some View {
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
            content
                .foregroundStyle(.black)
                .padding(.horizontal, 5)  // Add horizontal padding around the text field content.
                .padding(.vertical, 5)    // Add vertical padding around the text field content.
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

struct DecoratedTextEditorStyle : ViewModifier {
    func body(content: Content) -> some View {
        content
            .textEditorStyle(.plain)
            .scrollDisabled(true)
            .frame(maxWidth: .infinity, minHeight: 100)
            .multilineTextAlignment(.leading)
            .foregroundStyle(.black)
            .padding(5)    // Add vertical padding around the text field content.
            .background(.white)  // Set the background color for the entire component.
            .clipShape(RoundedRectangle(cornerRadius: 5))  // Clip to a rounded rectangle.
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.black, lineWidth: 2)  // Add a black stroke around the rounded rectangle.
            )
    }
}

extension TextEditor {
    func decorated() -> some View {
        self.modifier(DecoratedTextEditorStyle())
    }
}

/// Extension on `Text` to easily apply the `DecoratedTextItemStyle` with a specific symbol.
extension Text {
    
    /// Decorates the text field by applying the `DecoratedTextItemStyle` with the given symbol.
    /// - Parameter symbol: The symbol to use for decoration.
    /// - Returns: A view that represents the decorated text field.
    func decorated(by symbol: String) -> some View {
        self.modifier(DecoratedTextItemStyle(symbol: symbol))
    }
}


#Preview {
    VStack {
        Text("Tax Payer 1")
            .decorated(by: "person")
        TextEditor(text: .constant(""))
            .decorated()
        Spacer()
    }
    .padding()
}
