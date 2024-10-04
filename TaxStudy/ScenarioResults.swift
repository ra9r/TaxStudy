//
//  ResultsView.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 9/28/24.
//

import SwiftUI

struct ScenarioResults : View {
    var scenario: TaxScenario
    
    let columns = [
        GridItem(.flexible()),  // Flexible width
        GridItem(.flexible())   // Flexible width
    ]
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(alignment: .center, spacing: 20)  {
                CurrencyCard(title: "Gross Income", value: scenario.grossIncome)
                CurrencyCard(title: "After Tax Income", value: scenario.afterTaxIncome)
                CurrencyCard(title: "Deduction", value: scenario.federalTaxes.deduction)
                
                CurrencyCard(title: "Federal Taxes", value: scenario.federalTaxes.taxesOwed)
                CurrencyCard(title: "State Taxes", value: scenario.stateTaxes.taxesOwed)
                
                CurrencyCard(title: "Total Taxes", value: scenario.totalTaxesOwed)
                PercentageCard(title: "Effective Tax Rate", value: scenario.totalEffectiveTaxRate)
            }
        }
        .padding()
    }
}


