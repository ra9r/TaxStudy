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
    @Binding var reportConfig: ReportConfig

    
    var body: some View {
        VStack {
            HStack {
                ForEach(Array(scenarios), id: \.id) { scenario in
                    KeyMetricsStack(scenario: scenario, reportConfig: $reportConfig)
                }
            }
            Spacer()
        }
        .padding()
    }
}
