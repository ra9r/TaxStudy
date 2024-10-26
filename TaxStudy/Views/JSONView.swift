//
//  JSONView.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/9/24.
//

import SwiftUI

struct JSONView: View {
    var facts: [TaxFacts]
    public var body: some View {
        HStack {
            ZStack {
                // App Icon
                Image("AppIcon") // Replace with your actual AppIcon name
                    .resizable()
                    .frame(width: 64, height: 64)
                    .cornerRadius(10)
                
                // Exclamation mark icon
                Image(systemName: "exclamationmark.triangle.fill")
                    .resizable()
                    .foregroundColor(.yellow)
                    .frame(width: 28, height: 28)
                    .offset(x: 18, y: -18)
            }
        }
        ScrollView {
            Button(action: {
                let textToCopy = String.prettyPrint(facts) ?? "No Data"
                copyToClipboard(textToCopy)
            }) {
                Text("Copy to Clipboard")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
            Text(String.prettyPrint(facts) ?? "No Data")
                .frame(maxWidth: .infinity, alignment: .leading) // Forces the Text to fill the width
                .padding()
        }
        // Function to handle copying text to clipboard
    }
    private func copyToClipboard(_ text: String) {
#if os(iOS)
        UIPasteboard.general.string = text
#elseif os(macOS)
        let pasteboard = NSPasteboard.general
        pasteboard.clearContents()
        pasteboard.setString(text, forType: .string)
#endif
    }
}
