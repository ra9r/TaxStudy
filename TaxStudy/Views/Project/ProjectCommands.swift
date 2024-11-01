//
//  MenuCommands.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/27/24.
//

import SwiftUI
import KeyWindow

struct ProjectCommands : Commands {
    @Environment(\.openWindow) var openWindow
    @Environment(\.newDocument) var newDocument
    @Environment(\.openDocument) var openDocument
    @Binding var taxFactsService : TaxFactsManager
    
    @KeyWindowValueBinding(TaxProjectDocument.self)
    var document: TaxProjectDocument?
    
    init(_ taxFactsService: Binding<TaxFactsManager>) {
        self._taxFactsService = taxFactsService
    }
    
    
    var body: some Commands {
        
        CommandGroup(after: .appSettings) {
            Button("Tax Facts...") {
                openWindow(id: "txcfg")
            }
            .keyboardShortcut(",", modifiers: [.command])
        }
     
        CommandGroup(after: .importExport) {
            Button("Import TaxFacts...") {
                importTaxFacts()
            }
            Button("Export TaxFacts...") {
                exportTaxFacts()
            }
        }
        CommandGroup(after: .newItem) {
            Button("New Scenario") {
                newScenario()
            }
            .disabled(document == nil)
            .keyboardShortcut("n", modifiers: [.command, .shift])
        }
    }
    
    func newScenario() {
        guard let document else {
            fatalError("Unabled to create new TaxScenario, no TaxProjectDocument found")
        }
        guard let firstFact = document.facts.first else {
            fatalError("Unabled to create new TaxScenario, no TaxFacts found")
        }
        let newScenario = TaxScenario(name: "New Scenario", facts: firstFact.id)
        
        document.scenarios.append(newScenario)
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
