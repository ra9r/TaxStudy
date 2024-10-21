//
//  SettingsMenu.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/21/24.
//
import SwiftUI

struct SettingsCommand: Commands {
    @Environment(\.openWindow) var openWindow
    @State var appServices: AppServices
    
    var body: some Commands {
        CommandGroup(replacing: .appSettings) {
            Button("Settings...") {
                openWindow(id: "settings")
            }
            .keyboardShortcut(",", modifiers: [.command])
        }
    }
}
