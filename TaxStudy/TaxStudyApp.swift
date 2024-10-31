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
    @State var taxFactsServices = TaxFactsManager()
    
    var body: some Scene {
              
        DocumentGroup(newDocument: TaxProjectDocument()) { file in
            ProjectView(file.$document)
                .environment(taxFactsServices)
                .observeWindow()
        }
        .defaultSize(width: 1280, height: 1024)
        .keyboardShortcut("N", modifiers: [.command])
        .commands {
            ProjectCommands($taxFactsServices)
        }
        
//        Settings {
//            SettingsView(facts: $defaultFacts)
//        }
    }

}
