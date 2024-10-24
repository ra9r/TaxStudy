//
//  AppServices.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/19/24.
//

import SwiftUI

@Observable
class AppServices {
    var facts: [TaxFacts]
    var scenarios: [TaxScenario]
    
    init(facts: [TaxFacts]? = nil, scenarios: [TaxScenario] = []) {
        self.facts = facts ?? [DefaultTaxFacts2024]
        self.scenarios = scenarios
    }
    
    func facts(for id: String) -> TaxFacts? {
        guard let fact = facts.first(where: { $0.id == id }) else {
            print("Error: No Fact Found for \(id)")
            return nil
        }
        return fact
    }
}
