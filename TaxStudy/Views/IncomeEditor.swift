//
//  ScenarioEditor.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 9/28/24.
//

import SwiftUI

struct IncomeEditor: View {
    @Environment(TaxScenarioManager.self) var manager
    
    var body: some View {
        @Bindable var scenario = manager.selectedTaxScenario
        ScrollView {
            GroupBox("Wages") {
                CurrencyField(title: "Self", amount: $scenario.wagesSelf)
                CurrencyField(title: "Spouse", amount: $scenario.wagesSpouse)
            }
            GroupBox("Social Security") {
                CurrencyField(title: "Self", amount: $scenario.socialSecuritySelf)
                CurrencyField(title: "Spouse", amount: $scenario.socialSecuritySpouse)
            }
            GroupBox("Capital Gains") {
                CurrencyField(title: "Long-term", amount: $scenario.longTermCapitalGains)
                CurrencyField(title: "Short-term", amount: $scenario.shortTermCapitalGains)
            }
            GroupBox("Capital Losses") {
                CurrencyField(title: "Long-term", amount: $scenario.longTermCapitalLosses)
                CurrencyField(title: "Short-term", amount: $scenario.shortTermCapitalLosses)
                CurrencyField(title: "Carryover", amount: $scenario.capitalLossCarryOver)
            }
            GroupBox("Dividends") {
                CurrencyField(title: "Qualified", amount: $scenario.qualifiedDividends)
                CurrencyField(title: "Ordinary", amount: $scenario.nonQualifiedDividends)
            }
            GroupBox("Interest") {
                CurrencyField(title: "Tax-Exempt Interest", amount: $scenario.taxExemptInterest)
                CurrencyField(title: "Interest", amount: $scenario.interest)
            }
            GroupBox("Retirement") {
                CurrencyField(title: "Roth Conversion", amount: $scenario.rothConversion)
                CurrencyField(title: "IRA Withdrawal", amount: $scenario.iraWithdrawal)
            }
            GroupBox("Other Income") {
                CurrencyField(title: "Rental Income", amount: $scenario.rentalIncome)
                CurrencyField(title: "Royalties", amount: $scenario.royalties)
                CurrencyField(title: "Business Income", amount: $scenario.businessIncome)
            }
        }
        .padding()
        .scrollIndicators(.never)
    }
    
}

#Preview {
    ContentView()
}
