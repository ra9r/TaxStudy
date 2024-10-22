//
//  IncomeView.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/17/24.
//

import SwiftUI

struct IncomeView: View {
    @Binding var scenario: TaxScenario
    
    init(_ scenario: Binding<TaxScenario>) {
        self._scenario = scenario
    }
    
    var body: some View {
        ScrollView {
            HStack(alignment: .top, spacing: 10) {
                IncomeEditor("Tax Exempt Income", $scenario.income, filter: IncomeType.taxExempt)
                IncomeEditor("Ordinary Income", $scenario.income, filter: IncomeType.ordinary)
                IncomeEditor("Investment Income", $scenario.income, filter: IncomeType.investment)
            }
        }
        .frame(minWidth: 800)
    }
}
