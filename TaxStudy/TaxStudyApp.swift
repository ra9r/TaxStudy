//
//  TaxStudyApp.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 9/27/24.
//

import SwiftData
import SwiftUI

@main
struct TaxStudyApp: App {
    @State var appService: AppServices = AppServices.shared
    var body: some Scene {
        DocumentGroup(newDocument: TaxScenarioDocument()) { file in
            ScenarioView(file.$document)
                .environment(appService)
                .setTabbingMode(.automatic) // Not working but leaving in
                .frame(minWidth: 1280, minHeight: 800)
        }
        .commands {
            SettingsCommand(appServices: appService)
        }
        
        DocumentGroup(viewing: TaxFactsDocument.self) { file in
            TaxFactsImportView(file.$document)
                .environment(appService)
                .frame(minWidth: 1280, minHeight: 800)
        }
         
        Window("Settings", id: "settings") {
            SettingsView()
                .environment(appService)
        }
        
        Window("Settings", id: "exportConfig") {
            JSONView()
                .environment(appService)
        }
    }

}
