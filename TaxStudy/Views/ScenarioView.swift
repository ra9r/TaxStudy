//
//  ScenarioView.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/1/24.
//
import SwiftUI

struct ScenarioView : View {
    @Binding var scenario: TaxScenario
    
    init(_ scenario: Binding<TaxScenario>) {
        self._scenario = scenario
    }
    
    var body: some View {
        ScrollView {
            VStack {
                SummaryView($scenario)
                IncomeView($scenario)
                DeductionsView($scenario)
            }
        }
        .tint(Color.accentColor)
        .navigationTitle(scenario.name)
    }
}
