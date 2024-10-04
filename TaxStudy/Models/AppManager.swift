//
//  AppManager.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/4/24.
//
import SwiftUI

@Observable
class AppManager {
    func openFile() -> URL? {
        let panel = NSOpenPanel()
        panel.title = "Choose a JSON file"
        panel.allowedContentTypes = [.json] // Specify file types if needed
        panel.allowsMultipleSelection = false
        panel.canChooseDirectories = false
        
        if panel.runModal() == .OK, let url = panel.url {
            NSDocumentController.shared.noteNewRecentDocumentURL(url)
            return url
        }
        
        return nil
    }
    
    func saveAsFile() -> URL? {
        let panel = NSSavePanel()
        panel.title = "Save your file"
        panel.message = "Choose a location to save the file"
        panel.allowedContentTypes = [.json]
        panel.nameFieldStringValue = "MyFile.json" // Default file name
        panel.canCreateDirectories = true
        
        // Default location is the user's Documents directory
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        panel.directoryURL = documentsURL
        
        // Run the save panel and save the file if the user presses "OK"
        if panel.runModal() == .OK, let url = panel.url {
            NSDocumentController.shared.noteNewRecentDocumentURL(url)
            return url
        }
        
        return nil
    }
}
