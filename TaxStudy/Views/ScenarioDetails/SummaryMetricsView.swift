//
//  KeyFigures.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/18/24.
//

import SwiftUI

struct SummaryMetricsView: View {
    @Environment(TaxSchemeManager.self) var taxSchemeManager
    var scenario: TaxScenario
    @Binding var reportConfig: ReportConfig
    
    
    var body: some View {
        CardView("Key Metrics") {
            if let selectedTaxScheme = taxSchemeManager.allTaxSchemes().first(where: { $0.id == scenario.taxSchemeId}) {
                HStack(alignment: .top) {
                    ForEach(reportConfig.detailReport, id: \.id) { section in
                        ReportItemStack(items: section.items,
                                        taxScheme: selectedTaxScheme,
                                        scenario: scenario)
                    }
                }
                .padding(.bottom)
            } else {
                Text("No Tax Scheme with ID: '\(scenario.taxSchemeId)' Found")
            }
        }
    }
}

#Preview {
    @Previewable @State var reportConfig = ReportConfig.default
    let scenario = TaxScenario(name: "Sample", taxSchemeId: TaxScheme.official2024.id)
    SummaryMetricsView(scenario: scenario, reportConfig: $reportConfig)
        .frame(width:800, height: 300)
        .environment(TaxSchemeManager())
}
