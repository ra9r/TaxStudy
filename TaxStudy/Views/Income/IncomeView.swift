//
//  IncomeView.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/17/24.
//

import SwiftUI

struct IncomeView: View {
    @Binding var ts: TaxScenario
    
    var body: some View {
        ScrollView {
            HStack(alignment: .top, spacing: 10) {
                IncomeEditor("Tax Exempt Income", $ts.income, filter: IncomeType.taxExempt)
                IncomeEditor("Ordinary Income", $ts.income, filter: IncomeType.ordinary)
                IncomeEditor("Investment Income", $ts.income, filter: IncomeType.investment)
            }
            .padding()
        }
        .frame(minWidth: 800)
    }
}

#Preview {
    @Previewable @State var scenario = TaxScenario(name: "Test Scenario")
    IncomeView(ts: $scenario)
}
