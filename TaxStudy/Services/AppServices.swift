//
//  AppServices.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/19/24.
//

import SwiftUI

@Observable
class AppServices {
    static let shared = AppServices()
    
    var data: AppData = AppData()
    var currentFile: URL?
    
    private init() { /* Do Nothing */ }
    
    // MARK: - Open Functions
    
    // Open function to read JSON from a file and decode it into the array of TaxScenario
    func open(from url: URL) throws {
        self.currentFile = url
        let data = try Data(contentsOf: url)  // Read the data from the file
        let decoder = JSONDecoder()
        
        self.data = try decoder.decode(AppData.self, from: data)
    }
    
    func openFile() throws {
        let panel = NSOpenPanel()
        panel.title = "Choose a JSON file"
        panel.allowedContentTypes = [.json] // Specify file types if needed
        panel.allowsMultipleSelection = false
        panel.canChooseDirectories = false
        
        if panel.runModal() == .OK, let url = panel.url {
            NSDocumentController.shared.noteNewRecentDocumentURL(url)
            try open(from: url)
        }
    }
    
    func openLastSavedFile() throws {
        let recentDocuments = NSDocumentController.shared.recentDocumentURLs
        
        if recentDocuments.isEmpty == false {
            try open(from: recentDocuments.last!)
        } else {
            try openFile()
        }
    }

    // MARK: - Save Functions
    
    // Save function to write the array of TaxScenario to a file in JSON format
    func save(to url: URL) throws {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted  // Pretty print the JSON for readability
        let data = try encoder.encode(self.data)  // Convert the array to JSON data
        
        try data.write(to: url, options: [.atomicWrite, .completeFileProtection])
        currentFile = url
        print("Tax scenarios saved successfully to \(url.path)")
    }
    
    func saveAsFile() throws {
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
            try save(to: url)
        }
    }
    
    func saveFile() throws {
        if let currentFile {
            try save(to: currentFile)
        } else {
            try saveAsFile()
        }
    }
    
}
