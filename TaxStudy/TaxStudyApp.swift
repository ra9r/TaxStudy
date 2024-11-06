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
    @State var taxFactsServices = TaxFactsManager()
    
    var body: some Scene {
              
        DocumentGroup(newDocument: TaxProjectDocument()) { file in
            ProjectView(file.$document)
                .environment(taxFactsServices)
                .observeWindow()
                .onChange(of: taxFactsServices.sharedFacts) { oldValue, newValue in
                    print("Saving shared facts")
                    taxFactsServices.saveSharedFacts()
                }
        }
        .defaultSize(width: 1280, height: 1024)
        .keyboardShortcut("N", modifiers: [.command])
        .commands {
            ProjectCommands($taxFactsServices)
        }
        
        Window("Tax Facts", id: "txcfg") {
            TaxFactsEditor()
                .environment(taxFactsServices)
                .onChange(of: taxFactsServices.sharedFacts) { oldValue, newValue in
                    print("Saving shared facts")
                    taxFactsServices.saveSharedFacts()
                }
        }
        .commands {
            TaxFactsEditorCommands($taxFactsServices)
        }
    }

}
