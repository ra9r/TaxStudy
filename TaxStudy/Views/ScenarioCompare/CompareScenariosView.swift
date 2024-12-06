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
//    @State var showKeyMetricsEditor: Bool = false
    
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
                               print("Add Metrics")
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
//        .sheet(isPresented: $showKeyMetricsEditor) {
//            KeyMetricEditorView(metrics: .constant([]))
//                .frame(minHeight: 400)
//        }
    }
}

