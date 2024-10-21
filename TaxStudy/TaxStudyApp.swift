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
                .setTabbingMode(.preferred) // Not working but leaving in
        }
        .commands {
            SettingsCommand(appServices: appService)
        }
        
        Window("Settings", id: "settings") {
            SettingsView()
                .environment(appService)
        }
    }

}
