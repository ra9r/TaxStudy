//
//  TaxStudyApp.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 9/27/24.
//

import SwiftUI

@main
struct TaxStudyApp: App {
    @Environment(\.openWindow) var openWindow
    @State var allFacts: [TaxFacts] = [DefaultTaxFacts2024]
    
    var body: some Scene {
        DocumentGroup(newDocument: TaxProjectDocument()) { file in
            ProjectView(file.$document)
        }
        .commands {
            CommandGroup(after: CommandGroupPlacement.appInfo) {
                Button("Settings...") {
                    openWindow(id: "TaxFactsEditor")
                }
                .keyboardShortcut(",", modifiers: .command)
            }
        }
        
        WindowGroup("Tax Facts", id: "TaxFactsEditor") {
            SettingsView(facts: $allFacts)
        }
    }

}
