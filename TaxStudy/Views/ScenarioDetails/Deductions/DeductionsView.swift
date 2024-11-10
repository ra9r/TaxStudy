//
//  DeductionsView.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/14/24.
//

import SwiftUI

struct DeductionsView: View {
    @Binding var scenario: TaxScenario
    
    var body: some View {
        ScrollView {
            HStack(alignment: .top, spacing: 10) {
                DeductionEditor("Adjustments", $scenario.adjustments)
                DeductionEditor("Deductions", $scenario.deductions)
                DeductionEditor("Credits", $scenario.credits)
            }
        }
        .frame(minWidth: 800)
    }
}
