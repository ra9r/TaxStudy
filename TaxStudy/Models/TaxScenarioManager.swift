//
//  TaxScenarios.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/3/24.
//
import SwiftUI

@Observable
class TaxScenarioManager {
    var taxScenarios: [TaxScenario] = []
    var selectedTaxScenario: TaxScenario
    var currentFile: URL?
    
    init() {
        selectedTaxScenario = TaxScenario(name: "Scenario \(Date.now.formatted())")
        taxScenarios.append(selectedTaxScenario)
    }

    
    func find(_ id: String) -> TaxScenario? {
        taxScenarios.first { $0.id == id }
    }
    
    func add(_ taxScenario: TaxScenario) {
        taxScenarios.append(taxScenario)
    }
    
    func update(_ taxScenario: TaxScenario) {
        taxScenarios.removeAll { $0.id == taxScenario.id }
        taxScenarios.append(taxScenario)
    }
    
    func delete(id: String) {
        taxScenarios.removeAll { $0.id == id }
    }
    
    // Save function to write the array of TaxScenario to a file in JSON format
    func save(to url: URL) throws {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted  // Pretty print the JSON for readability
        let data = try encoder.encode(taxScenarios)  // Convert the array to JSON data
        
        try data.write(to: url, options: [.atomicWrite, .completeFileProtection])
        currentFile = url
        print("Tax scenarios saved successfully to \(url.path)")
    }
    
    // Open function to read JSON from a file and decode it into the array of TaxScenario
    func open(from url: URL) throws {
        let data = try Data(contentsOf: url)  // Read the data from the file
        let decoder = JSONDecoder()
        
        self.taxScenarios = try decoder.decode([TaxScenario].self, from: data)
        self.selectedTaxScenario = taxScenarios.first ?? TaxScenario(name: "Scenario \(Date.now.formatted())")
        currentFile = url
        print("Tax scenarios loaded successfully from \(url.path)")
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
        }
    }
}
