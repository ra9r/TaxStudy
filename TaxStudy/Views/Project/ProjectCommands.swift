//
//  MenuCommands.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/27/24.
//

import SwiftUI
import KeyWindow

struct ProjectCommands : Commands {
//    @Environment(\.openWindow) var openWindow
//    @Environment(\.newDocument) var newDocument
//    @Environment(\.openDocument) var openDocument
    @Binding var taxFactsService : TaxSchemeManager
    
    @KeyWindowValueBinding(TaxProjectDocument.self)
    var document: TaxProjectDocument?
    
    init(_ taxFactsService: Binding<TaxSchemeManager>) {
        self._taxFactsService = taxFactsService
    }
    
    
    var body: some Commands {
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
        let newScenario = TaxScenario(name: "New Scenario", taxSchemeId: TaxScheme.official2024.id)
        
        document.scenarios.append(newScenario)
    }
}
