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
    
    @State var draggedSection: ReportSection?
    
    var body: some View {
        ScrollView {
            Grid(alignment: .leading, horizontalSpacing: 5, verticalSpacing: 0) {
                ReorderableForEach(reportSections, active: $draggedSection) { reportSection in
                    GridRow {
                        ReportHeaderRow(
                            reportSection: reportSection,
                            onAddSection: {
                                print("Add Section")
                            }, onAddChart: {
                                print("Add Chart")
                            }, onAddMetrics: {
                                selectedMetrics = reportSection.keyMetrics
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
                } moveAction: { from, to in
                    reportSections.move(fromOffsets: from, toOffset: to)
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


