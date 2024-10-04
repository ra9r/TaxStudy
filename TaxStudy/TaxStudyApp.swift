//
//  TaxStudyApp.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 9/27/24.
//

import SwiftUI
import SwiftData

@main
struct TaxStudyApp: App {
    @State var manager = TaxScenarioManager()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(manager)
        }
        .commands {
            CommandGroup(replacing: .newItem) {
                Button("New...") {
                    openNewWindow()
                }
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
                .disabled(manager.currentFile == nil)
                
                Button("Save As...") {
                    saveFileAs()
                }
                .keyboardShortcut("S", modifiers: [.command, .shift])
                .disabled(manager.taxScenarios.isEmpty)
            }
        }
    }
    
    func openFile() {
        do {
            try manager.openFile()
        } catch {
            print(error)
        }
    }
    
    func saveFileAs() {
        do {
            try manager.saveAsFile()
        } catch {
            print(error)
        }
    }
    
    func saveFile() {
        do {
            try manager.saveFile()
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
                        try manager.open(from: url)
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
            .environment(manager)
        
        newWindow.contentView = NSHostingView(rootView: contentView)
        
        let windowController = NSWindowController(window: newWindow)
        windowController.showWindow(nil)
    }
}
