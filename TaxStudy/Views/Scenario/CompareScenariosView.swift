//
//  CompareScenariosView.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 11/9/24.
//

import SwiftUI

struct CompareScenariosView : View {
    @Environment(TaxSchemeManager.self) var taxSchemeManager
    @Binding var scenarios: Set<TaxScenario>
    @State var keyMetrics: Set<KeyMetricTypes> = [
        .grossIncome,
        .totalIncome,
        .agi,
        .taxableIncome,
    ]
    
    var body: some View {
        VStack {
            HStack {
                ForEach(Array(scenarios), id: \.id) { scenario in
                    KeyMetricsStack(scenario: scenario, keyMetrics: $keyMetrics)
                }
            }
            Spacer()
        }
        .padding()
    }
}
