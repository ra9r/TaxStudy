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
    @State var manager = TaxScenarioManager()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(manager)
                .onAppear {
                    do {
                        try manager.openLastSavedFile()
                    } catch {
                        print("No saved file found.")
                        print(error)
                    }
                }
        }
        .commands {
            FileCommands(manager: manager)
            ToolbarCommands()
            SidebarCommands()
            TextEditingCommands()
//            TextFormattingCommands()
        }
    }

}
