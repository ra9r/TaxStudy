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
    @State var allFacts: [TaxFacts] = [DefaultTaxFacts2024]
    
    var body: some Scene {
        DocumentGroup(newDocument: TaxProjectDocument()) { file in
            ProjectView(file.$document)
                .observeWindow()
        }
        .commands {
            ProjectCommands()
        }
        
        Settings {
            SettingsView(facts: $allFacts)
        }
    }

}
