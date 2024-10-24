//
//  SettingsMenu.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/21/24.
//
import SwiftUI

struct SettingsCommand: Commands {
    @Environment(\.openWindow) var openWindow
    
    
    var body: some Commands {
        CommandGroup(replacing: .appSettings) {
            Button("Settings...") {
                openWindow(id: "settings")
            }
            .keyboardShortcut(",", modifiers: [.command])
        }
    }
}

// Export Command
struct ExportConfigCommand: Commands {
    var body: some Commands {
        CommandGroup(after: .importExport) {
            Button("Export TaxFacts...") {
                exportTaxFacts()
            }
        }
    }
    
    func exportTaxFacts() {
        // Initialize a save panel
        let savePanel = NSSavePanel()
        savePanel.title = "Save Tax Facts"
        savePanel.nameFieldStringValue = "TaxFacts.txcfg" // default file name
        savePanel.allowedContentTypes = [.txcfg] // match your UTType definition
        savePanel.canCreateDirectories = true
        
        // Show the save panel
        savePanel.begin { response in
            if response == .OK, let url = savePanel.url {
                do {
                    let taxFactsDocument = TaxFactsDocument(facts: AppServices.shared.facts)
                    let data = try taxFactsDocument.jsonData()
                    try data.write(to: url)
                    print("File saved successfully at \(url.path)")
                } catch {
                    print("Failed to save the document: \(error)")
                }
            }
        }
    }

}
