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
            
            VStack {
                ForEach(section.items, id: \.id) { item in
                    AnyView(item.content(scenario: scenario, taxScheme: taxScheme))
                }
                .onMove(perform: move)
            }
            .sheet(isPresented: $showKeyMetricPicker) {
//                KeyMetricsPickerView(selectedKeyMetrics: $keyMetrics)
//                    .frame(minHeight: 300)
            }
        }
    }
    
    func move(from source: IndexSet, to destination: Int) {
        section.items.move(fromOffsets: source, toOffset: destination)
    }
}

#Preview {
    @Previewable @State var reportConfig = ReportConfig.default
    let scenario = TaxScenario(name: "Sample", taxSchemeId: TaxScheme.official2024.id)
    KeyMetricsStack(scenario: scenario, reportConfig: $reportConfig)
        .environment(TaxSchemeManager())
}
