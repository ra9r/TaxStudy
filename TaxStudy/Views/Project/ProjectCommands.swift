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
    
    @KeyWindowValueBinding(TaxProjectDocument.self)
    var document: TaxProjectDocument?
    
    
    var body: some Commands {
     
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
        CommandGroup(after: CommandGroupPlacement.appInfo) {
            Button("Settings...") {
                openWindow(id: "TaxFactsEditor")
            }
            .keyboardShortcut(",", modifiers: .command)
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
                print("Import from: \(url.path)")
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
                print("Export to: \(url.path)")
            }
        }
    }
}
