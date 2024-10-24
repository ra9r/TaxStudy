//
//  TaxScenarioDocument.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/21/24.
//

import SwiftUI
import UniformTypeIdentifiers

struct TaxProjectDocument: FileDocument, Identifiable {
    
    var id = UUID()
    
    // The file format this document supports
    static var readableContentTypes: [UTType] = [.txproj]

    // The data model that will hold the decoded JSON content
    var content: TaxProjectDocumentData
    
    // Default initializer
    init() {
        self.content = TaxProjectDocumentData()
    }
    
    // Required initializer to read the file from disk
    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents else {
            throw CocoaError(.fileReadCorruptFile)
        }
        
        // Decode the JSON data from the file
        let decoder = JSONDecoder()
        self.content = try decoder.decode(TaxProjectDocumentData.self, from: data)
    }
    
    // Required function to save/write the document to disk
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let jsonData = try encoder.encode(content)
        return FileWrapper(regularFileWithContents: jsonData)
    }
}

class TaxProjectDocumentData : Codable {
    var name: String
    var facts: [TaxFacts]
    var scenarios: [TaxScenario]
    
    init(name: String? = nil, facts: [TaxFacts]? = nil, scenarios: [TaxScenario]? = nil) {
        self.name = name ?? "New Project"
        self.facts = facts ?? [DefaultTaxFacts2024]
        self.scenarios = scenarios ?? [TaxScenario(name: "New Scenario", facts: self.facts[0].id)]
    }
}
