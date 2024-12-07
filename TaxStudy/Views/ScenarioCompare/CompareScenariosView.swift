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
    
    @State var draggedSection: ReportSection?
    @State var draggedItem: ReportItem?
    
    var body: some View {
        ScrollView {
            Grid(alignment: .leading, horizontalSpacing: 5, verticalSpacing: 0) {
                // Report Sections
                ReorderableForEach(reportSections, active: $draggedSection) { reportSection in
                    // Report Section Header
                    GridRow {
                        ReportHeaderRow(
                            reportSection: reportSection,
                            onAddSection: {
                                if let index = reportSections.firstIndex(of: reportSection) {
                                    reportSections.insert(ReportSection(title: "New Section"), at: index + 1)
                                }
                            }, onAddChart: {
                                print("Add Chart")
                            }, onAddMetrics: {
                                print("Add Metrics")
                            }
                        )
                        .gridCellColumns(scenarios.count + 1)
                    }
                    .contextMenu {
                        Button("Delete") {
                            withAnimation {
                                reportSections.removeAll(where: {$0.id == reportSection.id})
                            }
                        }
                    }
                    // Report Section Items
                    ReorderableForEach(reportSection.items, active: $draggedItem) { reportItem in
                        GridRow {
                            ReportItemRow(item: reportItem, scenarios: $scenarios)
                        }
                        .contextMenu {
                            Button("Delete") {
                                withAnimation {
                                    if let sectionIndex = reportSections.firstIndex(of: reportSection) {
                                        reportSection.items.removeAll(where: { $0.id == reportItem.id })
                                        reportSections[sectionIndex] = reportSection
                                    }
                                }
                            }
                        }
                    } moveAction: { from, to in
                        if let sectionIndex = reportSections.firstIndex(of: reportSection) {
                            reportSections[sectionIndex].items.move(fromOffsets: from, toOffset: to)
                        }
                    }
                } moveAction: { from, to in
                    reportSections.move(fromOffsets: from, toOffset: to)
                }
            }
            .padding()
        }
        .background(Color.white)
    }
}

