//
//  TaxScenarioDocument.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/21/24.
//

import SwiftUI
import UniformTypeIdentifiers

struct TaxScenarioDocument: FileDocument {
    
    // The file format this document supports
    static var readableContentTypes: [UTType] { [.json] }

    // The data model that will hold the decoded JSON content
    var scenario: TaxScenario
    
    // Default initializer
    init(scenario: TaxScenario = TaxScenario(name: "New Tax Scenario", facts: "2024")) {
        self.scenario = scenario
    }
    
    // Required initializer to read the file from disk
    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents else {
            throw CocoaError(.fileReadCorruptFile)
        }
        
        // Decode the JSON data from the file
        let decoder = JSONDecoder()
        self.scenario = try decoder.decode(TaxScenario.self, from: data)
    }
    
    // Required function to save/write the document to disk
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let encoder = JSONEncoder()
        let jsonData = try encoder.encode(scenario)
        return FileWrapper(regularFileWithContents: jsonData)
    }
}
