//
//  ScenarioView.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/24/24.
//
import SwiftUI

struct ScenarioView : View {
    @Environment(TaxFactsManager.self) var taxFactsManager
    @Binding var scenario: TaxScenario
    var embeddedFacts: [TaxFacts]
    
    var body: some View {
        ScrollView {
            let allFacts = taxFactsManager.allFacts(includeEmbedded: embeddedFacts)
            let selectedFacts = allFacts.first(where: { $0.id == scenario.facts })
            VStack {
                HeaderView(allFacts: allFacts, scenario: $scenario)
                if let selectedFacts {
                    KeyMetricsView(facts: selectedFacts, scenario: $scenario)
                    ProfileView(scenario: $scenario)
                    IncomeView(scenario: $scenario)
                    DeductionsView(scenario: $scenario)
                } else {
                    Text("No facts found for this scenario.")
                }
            }
            .padding()
        }
        .tint(Color.accentColor)
    }
}
