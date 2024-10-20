//
//  TaxScenarios.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/3/24.
//
import SwiftUI

@Observable
class AppData : Codable {
    var facts: [String: TaxFacts]
    var scenarios: [TaxScenario]

    init(facts: [String : TaxFacts]? = nil, scenarios: [TaxScenario] = []) {
        self.facts = facts ?? ["2024": DefaultTaxFacts2024]
        self.scenarios = scenarios
    }
    
    func find(_ id: String) -> TaxScenario? {
        scenarios.first { $0.id == id }
    }
    
    func add(_ taxScenario: TaxScenario) {
        scenarios.append(taxScenario)
    }
    
    func update(_ taxScenario: TaxScenario) {
        scenarios.removeAll { $0.id == taxScenario.id }
        scenarios.append(taxScenario)
    }
    
    func delete(id: String) {
        scenarios.removeAll { $0.id == id }
    }
    
    enum CodingKeys: String, CodingKey {
        case facts
        case scenarios
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        facts = try container.decode([String: TaxFacts].self, forKey: .facts)
        scenarios = try container.decode([TaxScenario].self, forKey: .scenarios)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(facts, forKey: .facts)
        try container.encode(scenarios, forKey: .scenarios)
    }
    
}
