//
//  ScenarioView.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/24/24.
//
import SwiftUI

struct ScenarioView : View {
    @Environment(AppServices.self) var appServices
    @Binding var scenario: TaxScenario
    
    init(_ scenario: Binding<TaxScenario>) {
        _scenario = scenario
    }
    
    var body: some View {
        ScrollView {
            VStack {
                HeaderView($scenario)
                KeyMetricsView($scenario)
                ProfileView($scenario)
                IncomeView($scenario)
                DeductionsView($scenario)
            }
            .padding()
        }
        .tint(Color.accentColor)
    }
}
