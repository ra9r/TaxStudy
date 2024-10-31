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
            VStack {
                HeaderView(facts: allFacts, scenario: $scenario)
                KeyMetricsView(facts: allFacts, scenario: $scenario)
                ProfileView(scenario: $scenario)
                IncomeView(scenario: $scenario)
                DeductionsView(scenario: $scenario)
            }
            .padding()
        }
        .tint(Color.accentColor)
    }
}
