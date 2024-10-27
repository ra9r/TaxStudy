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
    
    @KeyWindowValueBinding(TaxProjectDocument.self)
    var document: TaxProjectDocument?
    
    
    var body: some Commands {
        CommandGroup(replacing: .newItem) {
            Button("New Project") {
                newDocument(contentType: .txproj)
            }
            .keyboardShortcut("n", modifiers: [.command, .shift])
            
            Button("New Scenario") {
                newScenario()
            }
            .keyboardShortcut("n", modifiers: .command)
        }
        CommandGroup(after: CommandGroupPlacement.appInfo) {
            Button("Settings...") {
                openWindow(id: "TaxFactsEditor")
            }
            .keyboardShortcut(",", modifiers: .command)
        }
        CommandMenu("Custom") {
            Button("How many scenarios?") {
                print("Scenarios: \(document?.scenarios.count ?? 0)")
            }
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
    
    
}
