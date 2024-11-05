//
//  TaxFactsService.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/29/24.
//
import Observation
import Foundation

@MainActor
@Observable
class TaxFactsManager {
    
    var officialFacts: [TaxFacts]
    var sharedFacts: [TaxFacts] = []
    
    var selectedFacts: TaxFacts
    
    init() {
        self.officialFacts = [TaxFacts.official2024]
        self.selectedFacts = TaxFacts.official2024
        self.selectedFacts = self.officialFacts.first!
    }

    func importFile(from url: URL) throws {
        let decoder = JSONDecoder()
        let data = try Data(contentsOf: url)
        self.sharedFacts = try decoder.decode([TaxFacts].self, from: data)
    }
    
    func exportFile(to url: URL) throws {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try encoder.encode(self.sharedFacts)
        try data.write(to: url)
    }
    
    func lookupFacts(id: String, embedded: [TaxFacts] = []) -> TaxFacts? {

        
        return allFacts(includeEmbedded: embedded).first { $0.id == id }
    }
    
    func allFacts(includeEmbedded: [TaxFacts] = []) -> [TaxFacts] {
        var allFacts: Set<TaxFacts> = []
        
        for facts in officialFacts {
            allFacts.insert(facts)
        }
        
        for facts in sharedFacts {
            allFacts.insert(facts)
        }
        
        for facts in includeEmbedded {
            allFacts.insert(facts)
        }
        
        return Array(allFacts)
    }
    
    func deleteSharedFact(id: String?) {
        guard let id else {
            print("Error: Unable to delete \(id ?? "NONE")")
            return
        }
        
        self.sharedFacts.removeAll { $0.id == id }
    }
}


