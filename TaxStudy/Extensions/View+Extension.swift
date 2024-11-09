//
//  View+Extension.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/21/24.
//

import SwiftUI
import AppKit

// Extension to access NSWindow from a SwiftUI View
extension View {
    func setTabbingMode(_ tabbingMode: NSWindow.TabbingMode) -> some View {
        self.background(WindowAccessor { window in
            window?.tabbingMode = tabbingMode
        })
    }
}

// A helper to access NSWindow from a SwiftUI view hierarchy
struct WindowAccessor: NSViewRepresentable {
    var callback: (NSWindow?) -> Void
    
    func makeNSView(context: Context) -> NSView {
        let nsView = NSView()
        DispatchQueue.main.async { [weak nsView] in
            if let window = nsView?.window {
                self.callback(window)
            }
        }
        return nsView
    }
    
    func updateNSView(_ nsView: NSView, context: Context) { }
}


struct UnderlinedTextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 12, weight: .medium))
            .foregroundColor(.gray)
            .multilineTextAlignment(.trailing)
            .frame(maxWidth: 80)
            .textFieldStyle(.plain)
            .overlay(Rectangle()
                .frame(height: 1)
                .foregroundColor(.gray.opacity(0.5)),
                     alignment: .bottom
            )
    }
}

extension View {
    func underlinedTextField() -> some View {
        self.modifier(UnderlinedTextFieldModifier())
    }
}
