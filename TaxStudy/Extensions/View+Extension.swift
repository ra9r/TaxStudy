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
