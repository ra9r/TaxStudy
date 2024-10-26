//
//  KeyFigures.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/18/24.
//

import SwiftUI

struct KeyMetricsView: View {
    var facts: [TaxFacts]
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
    @State var federalTaxes: FederalTaxCalc?
    @State var stateTaxes: NCTaxCalc?
    @State var errorMessage: String?
        
    
    var body: some View {
        CardView("Key Metrics") {
            if let federalTaxes = federalTaxes, let stateTaxes = stateTaxes {
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
            } else {
                Text("Error: \(errorMessage ?? "No data found.")")
            }
        }
        .onAppear() {
            guard let fact = facts.first(where: { $0.id == scenario.facts }) else {
                fatalError("No tax facts found with id: '\(scenario.facts)'")
            }
            self.federalTaxes = FederalTaxCalc(scenario, facts: fact)
            self.stateTaxes = NCTaxCalc(scenario, facts: fact)
        }
        
    }
}

