//
//  ScenarioView.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/24/24.
//
import SwiftUI

struct ScenarioDetailView : View {
    @Environment(TaxSchemeManager.self) var taxSchemeManager
    @Binding var scenario: TaxScenario
    @Binding var reportConfig: ReportConfig
    
    var embeddedFacts: [TaxScheme]
    
    var body: some View {
        ScrollView {
            VStack {
                HeaderView(scenario: $scenario)
                SummaryMetricsView(scenario: scenario, reportConfig: $reportConfig)
                ProfileView(scenario: $scenario)
                IncomeView(scenario: $scenario)
                DeductionsView(scenario: $scenario)
            }
            .padding()
        }
        .tint(Color.accentColor)
    }
}
