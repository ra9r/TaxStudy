//
//  ScenarioView.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/1/24.
//
import SwiftUI

struct ScenarioView : View {
    @Binding var document: TaxScenarioDocument
    
    init(_ document: Binding<TaxScenarioDocument>) {
        self._document = document
    }
    
    var body: some View {
        ScrollView {
            VStack {
                SummaryView($document.scenario)
                IncomeView($document.scenario)
                DeductionsView($document.scenario)
            }
        }
        .tint(Color.accentColor)
        .navigationTitle(document.scenario.name)
    }
}
