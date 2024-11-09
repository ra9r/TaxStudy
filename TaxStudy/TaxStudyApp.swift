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
    @State var taxFactsServices = TaxSchemeManager()
    
    var body: some Scene {
              
        DocumentGroup(newDocument: TaxProjectDocument()) { file in
            ProjectView(file.$document)
                .environment(taxFactsServices)
                .observeWindow()
                .onChange(of: taxFactsServices.sharedSchemes) { oldValue, newValue in
                    print("Saving shared facts")
                    taxFactsServices.saveSharedTaxSchemes()
                }
        }
        .defaultSize(width: 1280, height: 1024)
        .keyboardShortcut("N", modifiers: [.command])
        .commands {
            ProjectCommands($taxFactsServices)
        }
        
        Window("Tax Scheme Editor", id: "txcfg") {
            TaxSchemeEditor()
                .environment(taxFactsServices)
                .onChange(of: taxFactsServices.sharedSchemes) { oldValue, newValue in
                    print("Saving shared facts")
                    taxFactsServices.saveSharedTaxSchemes()
                }
        }
        .commands {
            TaxSchemeEditorCommands($taxFactsServices)
        }
    }

}
