//
//  SettingsCommands.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 11/5/24.
//

import SwiftUI

struct TaxFactsEditorCommands : Commands {
    @Binding var taxFactsService : TaxFactsManager
    
    init(_ taxFactsService: Binding<TaxFactsManager>) {
        self._taxFactsService = taxFactsService
    }
    
    var body: some Commands {
        CommandGroup(after: .saveItem) {
            Button("Save Shared Tax Facts...") {
                taxFactsService.saveSharedFacts()
            }
            .keyboardShortcut("s", modifiers: [.command])
        }
        CommandGroup(after: .importExport) {
            Button("Import TaxFacts...") {
                importTaxFacts()
            }
            Button("Export TaxFacts...") {
                exportTaxFacts()
            }
        }
        
    }
    
    func importTaxFacts() {
        let openPanel = NSOpenPanel()
        openPanel.canChooseFiles = true
        openPanel.canChooseDirectories = false
        openPanel.allowsMultipleSelection = false

        if openPanel.runModal() == .OK {
            if let url = openPanel.url {
                do {
                    try taxFactsService.importFile(from: url)
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }
    }
    
    func exportTaxFacts() {
        let savePanel = NSSavePanel()
        savePanel.canCreateDirectories = true
        savePanel.nameFieldStringValue = "Untitled" // Default file name
        savePanel.allowedContentTypes = [.txcfg] // Define the allowed file types (optional)
        
        if savePanel.runModal() == .OK {
            if let url = savePanel.url {
                do {
                    try taxFactsService.exportFile(to: url)
                } catch {
                    print("Error encoding defaultFacts: \(error)")
                }
            }
        }
    }
}
