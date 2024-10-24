//
//  SettingsMenu.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/21/24.
//
import SwiftUI

struct SettingsCommands: Commands {
    @Environment(\.openWindow) var openWindow
    
    
    var body: some Commands {
        CommandGroup(replacing: .appSettings) {
            Button("Settings...") {
                openWindow(id: "settings")
            }
            .keyboardShortcut(",", modifiers: [.command])
        }
    }
}

