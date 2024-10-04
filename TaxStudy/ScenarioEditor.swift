//
//  ScenarioEditor.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 9/28/24.
//

import SwiftUI

struct ScenarioEditor: View {
    @Environment(TaxScenarioManager.self) var manager
    
    var body: some View {
        @Bindable var scenario = manager.selectedTaxScenario
        ScrollView {
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
                CurrencyField(title: "Interest", amount: $scenario.interest)
            }
            GroupBox("Retirement") {
                CurrencyField(title: "HSA Contribution", amount: $scenario.hsaContribution)
                CurrencyField(title: "Roth Conversion", amount: $scenario.rothConversion)
                CurrencyField(title: "IRA Contribution", amount: $scenario.iraContribtuion)
                CurrencyField(title: "IRA Withdrawal", amount: $scenario.iraWithdrawal)
            }
            GroupBox("Deductions") {
                CurrencyField(title: "Margin Interest Expense", amount: $scenario.marginInterestExpense)
                CurrencyField(title: "Mortgage Interest Expense", amount: $scenario.mortgageInterestExpense)
                CurrencyField(title: "Medical and Dental Expense", amount: $scenario.medicalAndDentalExpense)
            }
        }
        .padding()
        .scrollIndicators(.never)
    }
    
}

#Preview {
    ContentView()
}
