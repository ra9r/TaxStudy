//
//  KeyMetricToggle.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 11/14/24.
//
import SwiftUI

struct KeyMetricToggle: View {
    var keyMetric: KeyMetricTypes
    @State var isOn: Bool
    @Binding var selectedKeyMetrics: [KeyMetricTypes]
    
    @State var selectedIncomeType: IncomeType?
    @State var selectedAdjustmentType: TaxAdjustmentType?
    @State var selectedDeductionsType: TaxDeductionType?
    @State var selectedCreditsType: TaxCreditType?
    
    var body: some View {
        Toggle(isOn: $isOn) {
            Text(keyMetric.label)
        }
        .onChange(of: isOn) { oldValue, newValue in
            print("\(keyMetric) is now \(newValue)")
            if newValue {
                selectedKeyMetrics.append(keyMetric)
            } else {
                selectedKeyMetrics.removeAll(where: { $0.id == keyMetric.id })
            }
        }
    }
}
