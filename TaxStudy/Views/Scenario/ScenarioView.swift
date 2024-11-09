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
            VStack {
                HeaderView(scenario: $scenario)
                KeyMetricsView(scenario: $scenario)
                ProfileView(scenario: $scenario)
                IncomeView(scenario: $scenario)
                DeductionsView(scenario: $scenario)
            }
            .padding()
        }
        .tint(Color.accentColor)
    }
}
