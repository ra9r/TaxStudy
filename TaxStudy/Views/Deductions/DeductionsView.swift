//
//  DeductionsView.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/14/24.
//

import SwiftUI

struct DeductionsView: View {
    @Binding var scenario: TaxScenario
    
    init(_ scenario: Binding<TaxScenario>) {
        self._scenario = scenario
    }
    
    var body: some View {
        ScrollView {
            HStack(alignment: .top, spacing: 10) {
                DeductionEditor("Adjustments", $scenario.adjustments)
                DeductionEditor("Deductions", $scenario.deductions)
                DeductionEditor("Credits", $scenario.credits)
            }
            .padding()
        }
        .frame(minWidth: 800)
    }
}
