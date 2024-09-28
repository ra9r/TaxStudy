//
//  ScenarioEditor.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 9/28/24.
//

import SwiftUI

struct ScenarioEditor: View {
    @Binding var scenario: TaxScenario
    
    var body: some View {
        ScrollView {
            Text("Financial Information")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top)
            
            VStack {
                InputField(title: "SSDI (Social Security)", text: $scenario.ssdi)
            }
            .padding(.bottom)
            VStack {
                InputField(title: "Long-term Capital Gains", text: $scenario.longTermCapitalGains)
                InputField(title: "Long-term Capital Losses", text: $scenario.longTermCapitalLosses)
                InputField(title: "Carryover Capital Losses", text: $scenario.capitalLossCarryOver)
                InputField(title: "Short-term Capital Gains", text: $scenario.shortTermCapitalGains)
                InputField(title: "Short-term Capital Losses", text: $scenario.shortTermCapitalLosses)
                InputField(title: "Qualified Dividends", text: $scenario.qualifiedDividends)
                InputField(title: "Non-Qualified Dividends", text: $scenario.nonQualifiedDividends)
                InputField(title: "Interest", text: $scenario.interest)
            }
            .padding(.bottom)
            VStack {
                InputField(title: "HSA Contribution", text: $scenario.hsaContribution)
                InputField(title: "Roth Conversion", text: $scenario.rothConversion)
                InputField(title: "IRA Contribution", text: $scenario.iraContribtuion)
                InputField(title: "IRA Withdrawal", text: $scenario.iraWithdrawal)
            }
            .padding(.bottom)
            VStack {
                InputField(title: "Margin Interest Expense", text: $scenario.marginInterestExpense)
                InputField(title: "Mortgage Interest Expense", text: $scenario.mortgageInterestExpense)
                InputField(title: "Medical and Dental Expense", text: $scenario.medicalAndDentalExpense)
            }
            .padding(.bottom)
        }
        .frame(maxHeight: .infinity)
    }
}

struct InputField: View {
    var title: String
    @Binding var text: String
    
    var formatter: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.currencySymbol = "$" // Set to your desired currency symbol
            formatter.maximumFractionDigits = 2
            return formatter
        }()

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .fontWeight(.bold)
            
            TextField("Enter amount", text: $text)//, formatter: formatter)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
}
