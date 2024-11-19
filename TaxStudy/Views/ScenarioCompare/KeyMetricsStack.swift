//
//  KeyMetricsStack.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 11/10/24.
//

import SwiftUI

struct KeyMetricsStack: View {
    @Environment(TaxSchemeManager.self) var taxSchemeManager
    var scenario: TaxScenario
    @Binding var reportConfig: ReportConfig
    
    
    var body: some View {
        ScrollView {
            if let selectedTaxScheme = taxSchemeManager.allTaxSchemes().first(where: { $0.id == scenario.taxSchemeId}) {
                ForEach(reportConfig.compareReport, id: \.id) { section in
                    KeyMetricsStackSection(
                        section: Binding(
                            get: { section },
                            set: { newSection in
                                if let index = reportConfig.compareReport.firstIndex(where: { $0.id == newSection.id }) {
                                    reportConfig.compareReport[index] = newSection
                                }
                            }
                        ),
                        taxScheme: selectedTaxScheme,
                        scenario: scenario)
                    .padding(.vertical, 2)
                }
            } else {
                Text("No Tax Scheme Assigned")
            }
        }
        
    }
}

struct KeyMetricsStackSection : View {
    @Binding var section: ReportSection
    var taxScheme: TaxScheme
    var scenario: TaxScenario
    @State var selectedReportItem: ReportItem?
    
    @State var showKeyMetricPicker: Bool = false
    var body: some View {
        CardView {
            HStack {
                Text(section.title)
                Spacer()
                Button {
                    showKeyMetricPicker = true
                } label: {
                    Image(systemName: "plus")
                }
                .buttonStyle(.plain)
            }
        } content: {
            ScrollView {
                VStack {
                    let columns = Array(repeating: GridItem(spacing: 2), count: 1)
                    LazyVGrid(columns: columns, spacing: 2) {
                        ReorderableForEach(section.items, active: $selectedReportItem) { item in
                            item.content(scenario: scenario, taxScheme: taxScheme)
                                .padding()
                                .background(.white)
                        } moveAction: { source, destination in
                            section.items.move(fromOffsets: source, toOffset: destination)
                        }
                    }
                }
            }
            .sheet(isPresented: $showKeyMetricPicker) {
                KeyMetricsPickerView(selectedKeyMetrics: section.keyMetrics)
                    .frame(minHeight: 300)
            }
        }
    }
}

#Preview {
    @Previewable @State var reportConfig = ReportConfig.default
    let scenario = TaxScenario(name: "Sample", taxSchemeId: TaxScheme.official2024.id)
    KeyMetricsStack(scenario: scenario, reportConfig: $reportConfig)
        .environment(TaxSchemeManager())
}
