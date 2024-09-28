//
//  ResultsView.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 9/28/24.
//

import SwiftUI

struct ResultsView : View {
    @State var scenario: TaxScenario

    var body: some View {
        VStack {
            Text("Results")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top)
            
            VStack {
                OutputField(title: "Gross Income", value: formattedCurrency(scenario.grossIncome))
                OutputField(title: "AGI", value: formattedCurrency(scenario.agi))
                OutputField(title: "MAGI", value: formattedCurrency(scenario.magi))
                OutputField(title: "Deductions", value: formattedCurrency(scenario.deduction))
                OutputField(title: "Federal Taxes", value: formattedCurrency(scenario.federalTaxes))
                OutputField(title: "Federal Tax Rate", value: String(format: "%.2f%%", scenario.effectiveFedTaxRate * 100))
            }
            VStack {
                OutputField(title: "NC State Taxes", value: formattedCurrency(scenario.ncStateTaxes))
                OutputField(title: "NC State Tax Rate", value: String(format: "%.2f%%", scenario.effectiveStateTaxRate * 100))
            }
            VStack {
                OutputField(title: "Total Taxes", value: formattedCurrency(scenario.totalTaxes))
                OutputField(title: "Effective Tax Rate", value: String(format: "%.2f%%", scenario.effectiveTaxRate * 100))
                OutputField(title: "After Tax Income", value: formattedCurrency(scenario.afterTaxIncome))
            }
            .padding(.bottom)
            
            VStack {
                OutputField(title: "Net Capital Gain/Loss", value: formattedCurrency(scenario.netLTCG))
                OutputField(title: "Total Dividends", value: formattedCurrency(scenario.totalDividends))
                OutputField(title: "AGI Before SSDI", value: formattedCurrency(scenario.agiBeforeSSDI))
                OutputField(title: "Taxable SSDI", value: formattedCurrency(scenario.taxableSSDI))
                OutputField(title: "Taxable Income", value: formattedCurrency(scenario.taxableIncome))
                OutputField(title: "Ordinary Income", value: formattedCurrency(scenario.ordinaryIncome))
                OutputField(title: "Ordinary Income Tax", value: formattedCurrency(scenario.ordinaryIncomeTax))
                OutputField(title: "Carry Over Loss", value: formattedCurrency(scenario.futureCarryOverLoss))
                OutputField(title: "Dividend Tax", value: formattedCurrency(scenario.qualifiedDividendTax))
                OutputField(title: "LTCG Tax", value: formattedCurrency(scenario.capitalGainsTax))
            }
            .padding(.bottom)
        }
        .frame(height: .infinity)
    }
    
    func formattedCurrency(_ value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter.string(from: NSNumber(value: value)) ?? "$0.00"
    }
}

struct OutputField: View {
    var title: String
    var value: String

    var body: some View {
        HStack {
            Text(title)
                .fontWeight(.bold)
            Spacer()
            Text(value)
                .foregroundColor(.blue)
        }
    }
}
