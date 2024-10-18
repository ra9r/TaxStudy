//
//  KeyFigures.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/18/24.
//

import SwiftUI

struct KeyFigures: View {
    var federalTaxes: FederalTaxCalc

    var body: some View {
        CardView("Key Figures") {
            HStack(alignment: .top) {
                VStack {
                    CardItem("Total Income", value: federalTaxes.totalIncome.asCurrency)
                    CardItem("AGI", value: federalTaxes.agi.asCurrency)
                    CardItem("Deductions", value: federalTaxes.deduction.asCurrency)
                    CardItem("Taxable Income", value: federalTaxes.taxableIncome.asCurrency)
                    CardItem("Total Tax", value: federalTaxes.taxesOwed.asCurrency)
                }
                VStack {
                    CardItem("Filing Status", value: federalTaxes.scenario.filingStatus.rawValue)
                    CardItem("Marginal Rate", value: federalTaxes.marginalTaxRate.asPercentage)
                    CardItem("Avergae Rate", value: federalTaxes.effectiveTaxRate.asPercentage)
                    CardItem("Safe Harbor", value: federalTaxes.safeHarborTax.asCurrency)
                }
                VStack {
                    CardItem("Tax Exempt Interest", value: federalTaxes.scenario.taxExemptInterest.asCurrency)
                    CardItem("Qualified / Ordinary Dividends", value: "\(federalTaxes.scenario.qualifiedDividends.asCurrency) / \(federalTaxes.scenario.ordinaryDividends.asCurrency)")
                    CardItem("ST / LT Capital Gains", value: "\(federalTaxes.netSTCG.asCurrency) / \(federalTaxes.netLTCG.asCurrency)")
                    CardItem("Carryforward Loss", value: federalTaxes.futureCarryForwardLoss.asCurrency)
                    CardItem("Total / Taxable Social Security", value: "\(federalTaxes.scenario.totalSocialSecurityIncome.asCurrency) / \(federalTaxes.taxableSSDI.asCurrency)")
                }
            }
        }
    }
}

