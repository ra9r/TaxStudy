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
    @Binding var reportSections: [ReportSection]
    @State var showKeyMetricsEditor: Bool = false
    @State var selectedMetrics: [KeyMetricTypes] = []
    
    var body: some View {
        ScrollView {
            Grid(alignment: .leading, horizontalSpacing: 5, verticalSpacing: 0) {
                ForEach(reportSections, id: \.id) { reportSection in
                    GridRow {
                        ReportHeaderRow(
                            reportSection: reportSection,
                            onAddSection: {
                                print("Add Section")
                            }, onAddChart: {
                                print("Add Chart")
                            }, onAddMetrics: {
                                selectedMetrics = extractKeyMetrics(from: reportSection.items)
                                showKeyMetricsEditor = true
                            }
                        )
                        .gridCellColumns(scenarios.count + 1)
                    }
                    ForEach(reportSection.items, id: \.id) { reportItem in
                        GridRow {
                            ReportItemRow(item: reportItem, scenarios: $scenarios)
                        }
                    }
                }
            }
            .padding()
        }
        .background(Color.white)
        .sheet(isPresented: $showKeyMetricsEditor) {
            print("Dismissed!")
        } content: {
            KeyMetricEditorView(metrics: $selectedMetrics)
            .frame(minHeight: 400)
        }
    }
}

func extractKeyMetrics(from reportItems: [ReportItem]) -> [KeyMetricTypes] {
    reportItems.compactMap { reportItem in
        if case let .keyMetric(keyMetric) = reportItem {
            return keyMetric
        }
        return nil
    }
}

