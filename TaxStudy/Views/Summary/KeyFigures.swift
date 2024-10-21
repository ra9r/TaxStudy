//
//  KeyFigures.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/18/24.
//

import SwiftUI

struct KeyFigures: View {
    @Environment(AppServices.self) var appServices
    @Binding var scenario: TaxScenario
    
    init(_ scenario: Binding<TaxScenario>) {
        self._scenario = scenario
    }
    

    var body: some View {
        let facts = appServices.data.facts[scenario.facts]!
        let federalTaxes = FederalTaxCalc(scenario, facts: facts)
        let stateTaxes = NCTaxCalc(scenario, facts: facts)
        CardView("Key Metrics") {
            HStack(alignment: .top) {
                VStack {
                    CardItem("Total Income", value: federalTaxes.totalIncome.asCurrency(0))
                    CardItem("AGI", value: federalTaxes.agi.asCurrency(0))
                    CardItem("Deductions", value: federalTaxes.deduction.asCurrency(0))
                    CardItem("Taxable Income", value: federalTaxes.taxableIncome.asCurrency(0))
                    CardItem("Federal Taxes", value: federalTaxes.taxesOwed.asCurrency(0))
                    CardItem("FICA Taxes", value: federalTaxes.totalFICATax.asCurrency(0))
                    CardItem("State Taxes", value: stateTaxes.taxesOwed.asCurrency(0))
                }
                Divider()
                VStack {
                    CardPicker("Filing Status", selection: $scenario.filingStatus)
                    CardItem("Marginal Rate (Capital Gains)", value: federalTaxes.maginalCapitalGainsTaxRate.asPercentage)
                    CardItem("Marginal Rate (Ordinary Income)", value: federalTaxes.marginalOrdinaryTaxRate.asPercentage)
                    CardItem("Average Rate", value: federalTaxes.averageTaxRate.asPercentage)
                    CardItem("Safe Harbor", value: federalTaxes.safeHarborTax.asCurrency(0))
                }
                Divider()
                VStack {
                    CardItem("Tax Exempt Interest", value: federalTaxes.scenario.taxExemptInterest.asCurrency(0))
                    CardItem("Qualified / Ordinary Dividends", value: "\(federalTaxes.scenario.qualifiedDividends.asCurrency(0)) / \(federalTaxes.scenario.ordinaryDividends.asCurrency(0))")
                    CardItem("ST / LT Capital Gains", value: "\(federalTaxes.netSTCG.asCurrency(0)) / \(federalTaxes.netLTCG.asCurrency(0))")
                    CardItem("Carryforward Loss", value: federalTaxes.futureCarryForwardLoss.asCurrency(0))
                    CardItem("Provisional Income", value: federalTaxes.provisionalIncome.asCurrency(0))
                    CardItem("Total / Taxable Social Security", value: "\(federalTaxes.scenario.totalSocialSecurityIncome.asCurrency(0)) / \(federalTaxes.taxableSSI.asCurrency(0)) (\(federalTaxes.provisionalTaxRate.asPercentage))")
                }
            }
        }
    }
}

