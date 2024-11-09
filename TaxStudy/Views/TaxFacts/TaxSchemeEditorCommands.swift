//
//  SettingsCommands.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 11/5/24.
//

import SwiftUI

struct TaxSchemeEditorCommands : Commands {
    @Environment(\.openWindow) var openWindow
    @Binding var taxSchemeManager : TaxSchemeManager
    
    init(_ taxFactsService: Binding<TaxSchemeManager>) {
        self._taxSchemeManager = taxFactsService
    }
    
    var body: some Commands {
        CommandGroup(after: .appSettings) {
            Button("Tax Facts...") {
                openWindow(id: "txcfg")
            }
            .keyboardShortcut("t", modifiers: [.command, .shift])
        }
        CommandGroup(after: .saveItem) {
            Button("Save Shared Tax Facts...") {
                taxSchemeManager.saveSharedFacts()
            }
        }
        CommandGroup(after: .importExport) {
            Button("Import TaxScheme...") {
                importTaxSchemes()
            }
            Button("Export TaxScheme...") {
                exportTaxSchemes()
            }
        }
        
    }
    
    func importTaxSchemes() {
        let openPanel = NSOpenPanel()
        openPanel.canChooseFiles = true
        openPanel.canChooseDirectories = false
        openPanel.allowsMultipleSelection = false

        if openPanel.runModal() == .OK {
            if let url = openPanel.url {
                do {
                    try taxSchemeManager.importFile(from: url)
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }
    }
    
    func exportTaxSchemes() {
        let savePanel = NSSavePanel()
        savePanel.canCreateDirectories = true
        savePanel.nameFieldStringValue = "Untitled" // Default file name
        savePanel.allowedContentTypes = [.txcfg] // Define the allowed file types (optional)
        
        if savePanel.runModal() == .OK {
            if let url = savePanel.url {
                do {
                    try taxSchemeManager.exportFile(to: url)
                } catch {
                    print("Error encoding defaultFacts: \(error)")
                }
            }
        }
    }
}
