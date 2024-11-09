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
        
        loadSharedFacts()
    }
    
    func importFile(from url: URL) throws {
        let decoder = JSONDecoder()
        let data = try Data(contentsOf: url)
        self.sharedSchemes = try decoder.decode([TaxScheme].self, from: data)
    }
    
    func exportFile(to url: URL) throws {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try encoder.encode(self.sharedSchemes)
        try data.write(to: url)
    }
    
    func lookupFacts(id: String, embedded: [TaxScheme] = []) -> TaxScheme? {
        
        
        return allFacts(includeEmbedded: embedded).first { $0.id == id }
    }
    
    func allFacts(includeEmbedded: [TaxScheme] = []) -> [TaxScheme] {
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
    
    func newShared(from newFacts: TaxScheme) {
        sharedSchemes.append(newFacts)
        
//        saveSharedFacts()
    }
    
    func deleteSharedFact(id: String?) {
        guard let id else {
            print("Error: Unable to delete \(id ?? "NONE")")
            return
        }
        
        self.sharedSchemes.removeAll { $0.id == id }
//        saveSharedFacts()
    }
    
    func saveSharedFacts() {
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(sharedSchemes) {
            UserDefaults.standard.set(encodedData, forKey: "sharedFacts")
        }
    }
    
    func loadSharedFacts() {
        if let savedData = UserDefaults.standard.data(forKey: "sharedFacts") {
            let decoder = JSONDecoder()
            if let loadedFacts = try? decoder.decode([TaxScheme].self, from: savedData) {
                sharedSchemes = loadedFacts
            }
        }
    }
}


