//
//  ScenarioView.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/24/24.
//
import SwiftUI

struct ScenarioView : View {
    var facts: [TaxFacts]
    @Binding var scenario: TaxScenario
    
    var body: some View {
        ScrollView {
            VStack {
                HeaderView(facts: facts, scenario: $scenario)
                KeyMetricsView(facts: facts, scenario: $scenario)
                ProfileView(scenario: $scenario)
                IncomeView(scenario: $scenario)
                DeductionsView(scenario: $scenario)
            }
            .padding()
        }
        .tint(Color.accentColor)
    }
}
