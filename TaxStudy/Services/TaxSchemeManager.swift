//
//  TaxFactsService.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/29/24.
//
import Observation
import SwiftUI

@MainActor
@Observable
class TaxSchemeManager {
    
    var officialSchemes: [TaxScheme]
    var sharedSchemes: [TaxScheme] = []
    
    var selectedScheme: TaxScheme
    
    init() {
        self.officialSchemes = [TaxScheme.official2024]
        self.selectedScheme = TaxScheme.official2024
        self.selectedScheme = self.officialSchemes.first!
        
        loadSharedTaxSchemes()
    }
    
    func importSharedTaxSchemes(from url: URL) throws {
        let decoder = JSONDecoder()
        let data = try Data(contentsOf: url)
        self.sharedSchemes = try decoder.decode([TaxScheme].self, from: data)
    }
    
    func exportSharedTaxSchemes(to url: URL) throws {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try encoder.encode(self.sharedSchemes)
        try data.write(to: url)
    }
    
    func allTaxSchemes(includeEmbedded: [TaxScheme] = []) -> [TaxScheme] {
        var allFacts: Set<TaxScheme> = []
        
        for facts in officialSchemes {
            allFacts.insert(facts)
        }
        
        for facts in sharedSchemes {
            allFacts.insert(facts)
        }
        
        for facts in includeEmbedded {
            allFacts.insert(facts)
        }
        
        return Array(allFacts)
    }
    
    func newSharedTaxScheme(from source: TaxScheme, name: String) {
        let newFacts = source.deepCopy
        newFacts.id = UUID().uuidString
        newFacts.name = name
        sharedSchemes.append(newFacts)
    }
    
    func deleteSharedTaxScheme(id: String?) {
        guard let id else {
            print("Error: Unable to delete \(id ?? "NONE")")
            return
        }
        
        self.sharedSchemes.removeAll { $0.id == id }
        saveSharedTaxSchemes()
    }
    
    func saveSharedTaxSchemes() {
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(sharedSchemes) {
            UserDefaults.standard.set(encodedData, forKey: "sharedFacts")
        }
    }
    
    func loadSharedTaxSchemes() {
        if let savedData = UserDefaults.standard.data(forKey: "sharedFacts") {
            let decoder = JSONDecoder()
            if let loadedFacts = try? decoder.decode([TaxScheme].self, from: savedData) {
                sharedSchemes = loadedFacts
            }
        }
    }
    
    func moveSharedTaxSchemes(from source: IndexSet, to destination: Int) {
        sharedSchemes.move(fromOffsets: source, toOffset: destination)
        saveSharedTaxSchemes()
    }
}


