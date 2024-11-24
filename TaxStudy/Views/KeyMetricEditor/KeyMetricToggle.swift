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
    @Binding var selectedKeyMetrics: Set<KeyMetricTypes>
    
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
                selectedKeyMetrics.insert(keyMetric)
            } else {
                selectedKeyMetrics.remove(keyMetric)
            }
        }
    }
}
