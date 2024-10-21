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
        
        WindowGroup("Scenarios", id: "scenarios") {
            ContentView()
                .environment(appService)
                .background(.white)
                .onAppear {
                    if appService.currentFile == nil {
                        do {
                            try appService.openLastSavedFile()
                        } catch {
                            print("No saved file found.")
                            print(error)
                        }
                    }
                }
        }
        .commands {
            FileCommands(appServices: appService)
            ToolbarCommands()
            SidebarCommands()
            TextEditingCommands()
        }
        Window("Settings", id: "settings") {
            SettingsView()
                .environment(appService)
        }
    }

}
