//
//  AppServices.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/19/24.
//

import SwiftUI

class ProjectServices : ObservableObject {
    @Binding var document: TaxProjectDocument
    
    init(document: Binding<TaxProjectDocument>) {
        self._document = document
    }
    
    func facts(for id: String) -> TaxFacts? {
        guard let fact = document.facts.first(where: { $0.id == id }) else {
            print("Error: No Fact Found for \(id)")
            return nil
        }
        return fact
    }
    
    func firstFact() -> TaxFacts? {
        document.facts.first
    }
    
    func move(from source: IndexSet, to destination: Int) {
        document.scenarios.move(fromOffsets: source, toOffset: destination)
    }
    
    func newScenario() {
        guard let firstFact = firstFact() else {
            fatalError("Unabled to create new TaxScenario, no TaxFacts found")
        }
        let newScenario = TaxScenario(name: "New Scenario", facts: firstFact.id)
        
        document.scenarios.append(newScenario)
    }
    
    func delete(at selectedIndex: Int) {
        document.scenarios.remove(at: selectedIndex)
    }
    
    func duplicate(at selectedIndex: Int) {
        var scenario = document.scenarios[selectedIndex]
        
        document.scenarios.append(scenario.deepCopy)
    }
}
