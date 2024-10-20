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
        
        WindowGroup {
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
//            TextFormattingCommands()
        }
        Window("Settings", id: "settings") {
            TaxBracketEditor(filingStatus: .single, taxBrackets: DefaultTaxFacts2024.ordinaryTaxBrackets[.single]!)
        }
    }

}
