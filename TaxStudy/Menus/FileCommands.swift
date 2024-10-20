//
//  Menus.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/12/24.
//
import SwiftUI

struct FileCommands: Commands {
    @Environment(\.openWindow) var openWindow
    @State var appServices: AppServices
    
    var body: some Commands {
        CommandGroup(replacing: .newItem) {
            Button("New...") {
                openNewWindow()
            }
            .keyboardShortcut("N", modifiers: [.command])
            Button("Open...") {
                openFile()
            }
            .keyboardShortcut("O", modifiers: [.command])
            
            Menu("Open Recent") {
                openRecent()
            }
        }
        CommandGroup(replacing: .saveItem) {
            Button("Save") {
                saveFile()
            }
            .keyboardShortcut("S", modifiers: [.command])
            .disabled(appServices.currentFile == nil)
            
            Button("Save As...") {
                saveFileAs()
            }
            .keyboardShortcut("S", modifiers: [.command, .shift])
            .disabled(appServices.data.scenarios.isEmpty)
        }
        CommandGroup(replacing: .appSettings) {
            Button("Settings...") {
                openWindow(id: "settings")
            }
            .keyboardShortcut(",", modifiers: [.command])
        }
    }
    
    func openFile() {
        do {
            try appServices.openFile()
        } catch {
            print(error)
        }
    }
    
    func saveFileAs() {
        do {
            try appServices.saveAsFile()
        } catch {
            print(error)
        }
    }
    
    func saveFile() {
        do {
            try appServices.saveFile()
        } catch {
            print(error)
        }
    }
    
    @ViewBuilder
    func openRecent() -> some View {
        let recentDocuments = NSDocumentController.shared.recentDocumentURLs
        
        if recentDocuments.isEmpty {
            Text("No recent files")
        } else {
            ForEach(recentDocuments, id: \.self) { url in
                Button(action: {
                    do {
                        try appServices.open(from: url)
                    } catch {
                        print(error)
                    }
                }) {
                    Text(url.lastPathComponent)
                }
            }
        }
    }
    
    func openNewWindow() {
        let newWindow = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 400, height: 300),
            styleMask: [.titled, .closable, .resizable],
            backing: .buffered, defer: false
        )
        
        newWindow.title = "New Window"
        newWindow.center()
        
        let contentView = ContentView()
            .environment(appServices)
        
        newWindow.contentView = NSHostingView(rootView: contentView)
        
        let windowController = NSWindowController(window: newWindow)
        windowController.showWindow(nil)
    }
}
