//
//  TaxFactsService.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/29/24.
//
import Observation
import Foundation

@Observable
class TaxFactsService {
    
    var officialFacts: [TaxFacts]
    var customFacts: [TaxFacts] = []
    
    init() {
        self.officialFacts = [TaxFacts.official2024]
    }

    func importFile(from url: URL) throws {
        let decoder = JSONDecoder()
        let data = try Data(contentsOf: url)
        self.customFacts = try decoder.decode([TaxFacts].self, from: data)
    }
    
    func exportFile(to url: URL) throws {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try encoder.encode(self.customFacts)
        try data.write(to: url)
    }
}


