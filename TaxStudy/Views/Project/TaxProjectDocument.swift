//
//  TaxScenarioDocument.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/21/24.
//

import SwiftUI
import UniformTypeIdentifiers

@Observable
class TaxProjectDocument: FileDocument, Identifiable {
    
    
    // The file format this document supports
    static var readableContentTypes: [UTType] = [.txproj]

    // The data model that will hold the decoded JSON content
    var id = UUID()
    var name: String
    var facts: [TaxScheme]
    var scenarios: [TaxScenario]
    
    // Default initializer
    init(name: String? = nil, facts: [TaxScheme] = [], scenarios: [TaxScenario] = []) {
        self.name = name ?? "New Project"
        self.facts = facts
        self.scenarios = scenarios
    }
    
    // Required initializer to read the file from disk
    required init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents else {
            throw CocoaError(.fileReadCorruptFile)
        }
        
        // Decode the JSON data from the file
        let decoder = JSONDecoder()
        let content = try decoder.decode(TaxProjectDocumentData.self, from: data)
        self.name = content.name
        self.facts = content.facts
        self.scenarios = content.scenarios
    }
    
    // Required function to save/write the document to disk
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let jsonData = try encoder.encode(TaxProjectDocumentData(
            name: self.name,
            facts: self.facts,
            scenarios: self.scenarios
        ))
        return FileWrapper(regularFileWithContents: jsonData)
    }
    
    func newScenario() {
        self.scenarios.append(TaxScenario(name: "New Scenario", facts: self.facts[0].id))
    }
}

private class TaxProjectDocumentData : Codable, Equatable {
    static func == (lhs: TaxProjectDocumentData, rhs: TaxProjectDocumentData) -> Bool {
        return lhs.name == rhs.name
    }
    
    var name: String
    var facts: [TaxScheme]
    var scenarios: [TaxScenario]
    
    init(name: String? = nil, facts: [TaxScheme]? = nil, scenarios: [TaxScenario]? = nil) {
        self.name = name ?? "New Project"
        self.facts = facts ?? []
        self.scenarios = scenarios ?? [TaxScenario(name: "New Scenario", facts: self.facts[0].id)]
    }
}

import KeyWindow

extension TaxProjectDocument : KeyWindowValueKey {
    public typealias Value = Binding<TaxProjectDocument>
}
