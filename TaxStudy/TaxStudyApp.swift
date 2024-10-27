//
//  TaxStudyApp.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 9/27/24.
//

import SwiftUI
import KeyWindow

@main
struct TaxStudyApp: App {
    @Environment(\.openWindow) var openWindow
    @State var defaultFacts: [TaxFacts] = [DefaultTaxFacts2024]
    
    var body: some Scene {
              
        DocumentGroup(newDocument: TaxProjectDocument()) { file in
            ProjectView(file.$document)
                .observeWindow()
        }
        .defaultSize(width: 1280, height: 1024)
        .keyboardShortcut("N", modifiers: [.command])
        .commands {
            ProjectCommands(defaultFacts: $defaultFacts)
        }
        
        Settings {
            SettingsView(facts: $defaultFacts)
        }
    }

}
