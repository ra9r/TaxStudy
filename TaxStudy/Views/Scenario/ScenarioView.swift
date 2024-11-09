//
//  ScenarioView.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/24/24.
//
import SwiftUI

struct ScenarioView : View {
    @Environment(TaxSchemeManager.self) var taxSchemeManager
    @Binding var scenario: TaxScenario
    var embeddedFacts: [TaxScheme]
    
    var body: some View {
        ScrollView {
            let allFacts = taxSchemeManager.allFacts(includeEmbedded: embeddedFacts)
            let selectedFacts = allFacts.first(where: { $0.id == scenario.facts })
            VStack {
                HeaderView(allSchemes: allFacts, scenario: $scenario)
                if let selectedFacts {
                    KeyMetricsView(taxScheme: selectedFacts, scenario: $scenario)
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
