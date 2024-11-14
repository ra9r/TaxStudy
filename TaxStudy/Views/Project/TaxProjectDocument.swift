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
    var config: ReportConfig
    var taxSchemes: [TaxScheme]
    var scenarios: [TaxScenario]
    
    // Default initializer
    init(name: String? = nil,
         taxSchemes: [TaxScheme] = [],
         scenarios: [TaxScenario] = [],
         config: ReportConfig = ReportConfig()
    ) {
        self.name = name ?? "New Project"
        self.taxSchemes = taxSchemes
        self.scenarios = scenarios
        self.config = config
    }
    
    // Required initializer to read the file from disk
    required init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents else {
            throw CocoaError(.fileReadCorruptFile)
        }
        
        // Decode the JSON data from the file
        let decoder = JSONDecoder()
        do {
            let content = try decoder.decode(TaxProjectDocumentData.self, from: data)
            self.name = content.name
            self.taxSchemes = content.taxSchemes
            self.scenarios = content.scenarios
            self.config = ReportConfig.default //content.config
        } catch {
            print("Error decoding JSON: \(error)")
            throw error
        }
    }
    
    // Required function to save/write the document to disk
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let jsonData = try encoder.encode(TaxProjectDocumentData(
            name: self.name,
            taxSchemes: self.taxSchemes,
            scenarios: self.scenarios
        ))
        return FileWrapper(regularFileWithContents: jsonData)
    }
    
    func newScenario() {
        self.scenarios.append(TaxScenario(name: "New Scenario", taxSchemeId: self.taxSchemes[0].id))
    }
}

private class TaxProjectDocumentData : Codable, Equatable {
    static func == (lhs: TaxProjectDocumentData, rhs: TaxProjectDocumentData) -> Bool {
        return lhs.name == rhs.name
    }
    
    var name: String
    var taxSchemes: [TaxScheme]
    var scenarios: [TaxScenario]
    var config: ReportConfig
    
    init(name: String? = nil, taxSchemes: [TaxScheme]? = nil, scenarios: [TaxScenario]? = nil, config: ReportConfig? = nil) {
        self.name = name ?? "New Project"
        self.taxSchemes = taxSchemes ?? []
        self.scenarios = scenarios ?? [TaxScenario(name: "New Scenario", taxSchemeId: TaxScheme.official2024.id)]
        self.config = config ?? ReportConfig.default
    }
}

import KeyWindow

extension TaxProjectDocument : KeyWindowValueKey {
    public typealias Value = Binding<TaxProjectDocument>
}
