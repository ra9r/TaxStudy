//
//  KeyMetricsStackSection.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 11/23/24.
//
import SwiftUI

struct ReportItemStack : View {
    var items: [ReportItem]
    var taxScheme: TaxScheme
    var scenario: TaxScenario
    @State var draggingItem: ReportItem?
    
    var body: some View {
        let columns = Array(repeating: GridItem(spacing: 0), count: 1)
        LazyVGrid(columns: columns, spacing: 0) {
            ForEach(items) { item in
                item.content(scenario: scenario, taxScheme: taxScheme)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview("ForEach Version") {
    @Previewable @State var sections: [ReportSection] = [
        .init(title: "Section 1", items: [
            .keyMetric(.filingStatus),
            .keyMetric(.grossIncome),
            .keyMetric(.totalIncome)
        ]),
        .init(title: "Section 2", items: [
            .keyMetric(.agi),
            .keyMetric(.deduction),
            .keyMetric(.taxableIncome),
            .keyMetric(.amtIncome)
        ])
    ]
    
    let scenario = TaxScenario(name: "Sample", taxSchemeId: TaxScheme.official2024.id)
    ReportItemStack(
        items: sections[0].items,
        taxScheme: TaxScheme.official2024,
        scenario: scenario)
    .environment(TaxSchemeManager())
}

