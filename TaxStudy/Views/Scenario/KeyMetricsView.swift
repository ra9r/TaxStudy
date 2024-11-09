//
//  KeyFigures.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/18/24.
//

import SwiftUI

struct KeyMetricsView: View {
    var taxScheme: TaxScheme
    @Binding var scenario: TaxScenario
    @State var keyMetricGroups: [KeyMetricGroup] = [
        .init(title: "Column Left", keyMetrics: [
            .grossIncome,
            .totalIncome,
            .agi,
            .deduction,
            .taxableIncome,
            .amtIncome,
            .amtTax,
            .federalTax,
            .totalFICATax,
        ]),
        .init(title: "Column Middle", keyMetrics: [
            .filingStatus,
            .marginalOrdinaryTaxRate,
            .marginalCapitalGainsTaxRate,
            .averageTaxRate,
            .safeHarborTax,
            .irmaaSurcharges,
            .deductibleMedicalExpenses,
            .deductibleMedicalExpensesForAMT
        ]),
        .init(title: "Column Right", keyMetrics: [
            .totalTaxExemptInterestIncome,
            .dividends,
            .capitalGains,
            .futureCarryForwardLoss,
            .provisionalIncome,
            .totalSSAIncome,
        ])
    ]
        
    
    var body: some View {
        CardView("Key Metrics") {
            let federalTaxes = FederalTaxCalc(scenario, taxScheme: taxScheme)
            let stateTaxes = NCTaxCalc(scenario, taxScheme: taxScheme)
            HStack(alignment: .top) {
                VStack {
                    ForEach(keyMetricGroups[0].keyMetrics, id: \.label) { keyMetric in
                        CardItem(keyMetric.label, value: keyMetric.resolve(fedTax: federalTaxes, stateTax: stateTaxes))
                    }
                }
                Divider()
                VStack {
                    ForEach(keyMetricGroups[1].keyMetrics, id: \.label) { keyMetric in
                        CardItem(keyMetric.label, value: keyMetric.resolve(fedTax: federalTaxes, stateTax: stateTaxes))
                    }
                }
                Divider()
                VStack {
                    ForEach(keyMetricGroups[2].keyMetrics, id: \.label) { keyMetric in
                        CardItem(keyMetric.label, value: keyMetric.resolve(fedTax: federalTaxes, stateTax: stateTaxes))
                    }
                }
            }
        }
        
    }
}

