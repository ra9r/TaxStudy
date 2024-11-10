//
//  CompareScenariosView.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 11/9/24.
//

import SwiftUI

struct CompareScenariosView : View {
    @Environment(TaxSchemeManager.self) var taxSchemeManager
    @Binding var scenarios: Set<TaxScenario>
    @State var keyMetrics: [KeyMetricTypes] = [
        .grossIncome,
        .totalIncome,
        .agi,
        .deduction,
        .taxableIncome,
        .amtIncome,
        .amtTax,
        .federalTax,
        .totalFICATax,
        .divider,
        .filingStatus,
        .marginalOrdinaryTaxRate,
        .marginalCapitalGainsTaxRate,
        .averageTaxRate,
        .safeHarborTax,
        .irmaaSurcharges,
        .deductibleMedicalExpenses,
        .deductibleMedicalExpensesForAMT,
        .divider,
        .totalTaxExemptInterestIncome,
        .dividends,
        .capitalGains,
        .futureCarryForwardLoss,
        .provisionalIncome,
        .totalSSAIncome
    ]
    
    var body: some View {
        VStack {
            HStack {
                ForEach(Array(scenarios), id: \.id) { scenario in
                    CardView(scenario.name) {
                        if let selectedTaxScheme = taxSchemeManager.allTaxSchemes().first(where: { $0.id == scenario.taxSchemeId}) {
                            let federalTaxes = FederalTaxCalc(scenario, taxScheme: selectedTaxScheme)
                            let stateTaxes = NCTaxCalc(scenario, taxScheme: selectedTaxScheme)
                            
                            ForEach(keyMetrics, id: \.label) { keyMetric in
                                switch keyMetric {
                                case .divider:
                                    Divider()
                                default:
                                    CardItem(keyMetric.label, value: keyMetric.resolve(fedTax: federalTaxes, stateTax: stateTaxes))
                                }
                            }
                        } else {
                            Text("No Tax Scheme Assigned")
                        }
                        
                    }
                    
                }
            }
            Spacer()
        }
        .padding()
    }
}
