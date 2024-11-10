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
    @Binding var keyMetrics: Set<KeyMetricTypes>
    @State var showKeyMetricPicker: Bool = false
    
    var body: some View {
        CardView {
            HStack {
                Text(scenario.name)
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
                if let selectedTaxScheme = taxSchemeManager.allTaxSchemes().first(where: { $0.id == scenario.taxSchemeId}) {
                    let federalTaxes = FederalTaxCalc(scenario, taxScheme: selectedTaxScheme)
                    let stateTaxes = NCTaxCalc(scenario, taxScheme: selectedTaxScheme)
                    
                    ForEach(Array(keyMetrics), id: \.label) { keyMetric in
                        CardItem(keyMetric.label, value: keyMetric.resolve(fedTax: federalTaxes, stateTax: stateTaxes))
                    }
                } else {
                    Text("No Tax Scheme Assigned")
                }
            }
        }
        .sheet(isPresented: $showKeyMetricPicker) {
            KeyMetricsPickerView(selectedKeyMetrics: $keyMetrics)
                .frame(minHeight: 300)
        }
    }
}

#Preview {
    @Previewable @State var keyMetrics: Set<KeyMetricTypes> = [
        .grossIncome,
        .totalIncome,
        .agi,
        ]
    let scenario = TaxScenario(name: "Sample", taxSchemeId: TaxScheme.official2024.id)
    KeyMetricsStack(scenario: scenario, keyMetrics: $keyMetrics)
        .environment(TaxSchemeManager())
}
