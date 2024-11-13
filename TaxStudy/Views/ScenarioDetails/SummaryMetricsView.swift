//
//  KeyFigures.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/18/24.
//

import SwiftUI

struct SummaryMetricsView: View {
    @Environment(TaxSchemeManager.self) var taxSchemeManager
    @Binding var scenario: TaxScenario
    @State var reportSections: [ReportSection] = [
        .init(title: "Column Left", items: [
            KeyMetricReportItem(.grossIncome),
            KeyMetricReportItem(.totalIncome),
            KeyMetricReportItem(.agi),
            KeyMetricReportItem(.deduction),
            KeyMetricReportItem(.taxableIncome),
            KeyMetricReportItem(.amtIncome),
            KeyMetricReportItem(.amtTax),
            KeyMetricReportItem(.federalTax),
            KeyMetricReportItem(.totalFICATax),
        ]),
        .init(title: "Column Middle", items: [
            KeyMetricReportItem(.filingStatus),
            KeyMetricReportItem(.marginalOrdinaryTaxRate),
            KeyMetricReportItem(.marginalCapitalGainsTaxRate),
            KeyMetricReportItem(.averageTaxRate),
            DividerReportItem(),
            KeyMetricReportItem(.safeHarborTax),
            KeyMetricReportItem(.irmaaSurcharges),
            KeyMetricReportItem(.deductibleMedicalExpenses),
            KeyMetricReportItem(.deductibleMedicalExpensesForAMT),
        ]),
        .init(title: "Column Right", items: [
            KeyMetricReportItem(.totalTaxExemptInterestIncome),
            KeyMetricReportItem(.dividends),
            KeyMetricReportItem(.capitalGains),
            KeyMetricReportItem(.futureCarryForwardLoss),
            KeyMetricReportItem(.provisionalIncome),
            KeyMetricReportItem(.totalSSAIncome),
        ])
    ]
        
    
    var body: some View {
        CardView("Key Metrics") {
            if let selectedTaxScheme = taxSchemeManager.allTaxSchemes().first(where: { $0.id == scenario.taxSchemeId}) {
                HStack(alignment: .top) {
                    VStack {
                        ForEach(reportSections[0].items, id: \.id) { item in
                            AnyView(item.content(scenario: scenario, taxScheme: selectedTaxScheme))
                        }
                    }
                    Divider()
                    VStack {
                        ForEach(reportSections[1].items, id: \.id) { item in
                            AnyView(item.content(scenario: scenario, taxScheme: selectedTaxScheme))
                        }
                    }
                    Divider()
                    VStack {
                        ForEach(reportSections[2].items, id: \.id) { item in
                            AnyView(item.content(scenario: scenario, taxScheme: selectedTaxScheme))
                        }
                    }
                }
            } else {
                Text("No Tax Scheme with ID: '\(scenario.taxSchemeId)' Found")
            }
        }
        
    }
}

