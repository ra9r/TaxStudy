//
//  KeyFigures.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/18/24.
//

import SwiftUI

struct KeyMetricsView: View {
    @Environment(AppServices.self) var appServices
    @Binding var scenario: TaxScenario
    @State var keyMetricGroups: [KeyMetricGroup] = [
        .init(title: "Column Left", keyMetrics: [
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
    
    init(_ scenario: Binding<TaxScenario>) {
        self._scenario = scenario
    }
    
    
    var body: some View {
        if let facts = appServices.facts(for: scenario.facts) {
            let federalTaxes = FederalTaxCalc(scenario, facts: facts)
            let stateTaxes = NCTaxCalc(scenario, facts: facts)
            
            CardView("Key Metrics") {
                HStack(alignment: .top) {
                    VStack {
                        ForEach(keyMetricGroups[0].keyMetrics, id: \.label) { keyMetric in
                            KeyMetricItem(keyMetric: keyMetric, federalTaxes: federalTaxes, stateTaxes: stateTaxes)
                        }
                    }
                    Divider()
                    VStack {
                        ForEach(keyMetricGroups[1].keyMetrics, id: \.label) { keyMetric in
                            KeyMetricItem(keyMetric: keyMetric, federalTaxes: federalTaxes, stateTaxes: stateTaxes)
                        }
                    }
                    Divider()
                    VStack {
                        ForEach(keyMetricGroups[2].keyMetrics, id: \.label) { keyMetric in
                            KeyMetricItem(keyMetric: keyMetric, federalTaxes: federalTaxes, stateTaxes: stateTaxes)
                        }
                    }
                }
            }
        } else {
            Text("Error: No facts found for \(scenario.facts).")
        }
    }
}

struct KeyMetricItem : View {
    let keyMetric: KeyMetricTypes
    let federalTaxes: FederalTaxCalc
    let stateTaxes: NCTaxCalc
    @State var showError: Bool = false
    @State var errorMessage: String?
    @State var value: String?
    
    var body: some View {
        Group {
            if showError {
                CardItem(keyMetric.label, value: "error")
                    .help(errorMessage!)
            } else {
                if let value {
                    CardItem(keyMetric.label, value: value)
//                        .help(keyMetric.description)
                } else {
                    CardItem(keyMetric.label, value: "--")
                }
            }
        }
        .task {
            do {
                self.value = try keyMetric.resolve(fedTax: federalTaxes, stateTax: stateTaxes)
            } catch {
                self.errorMessage = error.localizedDescription
                self.showError.toggle()
            }
        }
    }
}
