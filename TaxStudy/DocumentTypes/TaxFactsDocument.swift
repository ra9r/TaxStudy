//
//  TaxScenarioDocument.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/21/24.
//

import SwiftUI
import UniformTypeIdentifiers

struct TaxFactsDocument: FileDocument {
    
    // The file format this document supports
    static var readableContentTypes: [UTType] { [.txcfg] }

    // The data model that will hold the decoded JSON content
    var facts: [TaxFacts]
    
    // Default initializer
    init(facts: [TaxFacts] = [DefaultTaxFacts2024]) {
        self.facts = facts
    }
    
    // Required initializer to read the file from disk
    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents else {
            print("Error: Could not read file")
            throw CocoaError(.fileReadCorruptFile)
        }
        // Decode the JSON data from the file
        let decoder = JSONDecoder()
        do {
            self.facts = try decoder.decode([TaxFacts].self, from: data)
        } catch {
            print(error)
            throw error
        }
    }
    
    // Required function to save/write the document to disk
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let jsonData = try encoder.encode(facts)
        return FileWrapper(regularFileWithContents: jsonData)
    }
}
