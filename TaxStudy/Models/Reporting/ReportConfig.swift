//
//  KeyMetricConfig.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 11/13/24.
//

import SwiftUI

class ReportConfig: Codable {
    var detailReport: [ReportSection]
    var compareReport: [ReportSection]
    
    init(detailReport: [ReportSection] = [], compareReport: [ReportSection] = []) {
        self.detailReport = detailReport
        self.compareReport = compareReport
    }
    
    static let `default`: ReportConfig = ReportConfig(detailReport: [
        .init(title: "Column Left", items: [
            .init(type: .keyMetric(.grossIncome)),
            .init(type: .keyMetric(.totalIncome)),
            .init(type: .keyMetric(.agi)),
            .init(type: .keyMetric(.deduction)),
            .init(type: .keyMetric(.taxableIncome)),
            .init(type: .keyMetric(.amtIncome)),
            .init(type: .keyMetric(.amtTax)),
            .init(type: .keyMetric(.federalTax)),
            .init(type: .keyMetric(.totalFICATax)),
        ]),
        .init(title: "Column Middle", items: [
            .init(type: .keyMetric(.filingStatus)),
            .init(type: .keyMetric(.marginalOrdinaryTaxRate)),
            .init(type: .keyMetric(.marginalCapitalGainsTaxRate)),
            .init(type: .keyMetric(.averageTaxRate)),
            .init(type: .divider),
            .init(type: .keyMetric(.safeHarborTax)),
            .init(type: .keyMetric(.irmaaSurcharges)),
            .init(type: .keyMetric(.deductibleMedicalExpenses)),
            .init(type: .keyMetric(.deductibleMedicalExpensesForAMT)),
        ]),
        .init(title: "Column Right", items: [
            .init(type: .keyMetric(.totalTaxExemptInterestIncome)),
            .init(type: .keyMetric(.dividends)),
            .init(type: .keyMetric(.capitalGains)),
            .init(type: .keyMetric(.futureCarryForwardLoss)),
            .init(type: .keyMetric(.provisionalIncome)),
            .init(type: .keyMetric(.totalSSAIncome)),
        ])
    ], compareReport: [
        .init(title: "Summary", items: [
            .init(type: .keyMetric(.filingStatus)),
            .init(type: .keyMetric(.grossIncome)),
            .init(type: .keyMetric(.totalIncome)),
            .init(type: .keyMetric(.agi)),
            .init(type: .keyMetric(.deduction)),
            .init(type: .keyMetric(.taxableIncome)),
            .init(type: .keyMetric(.amtIncome)),
        ]),
        .init(title: "Taxes", items: [
            .init(type: .keyMetric(.amtTax)),
            .init(type: .keyMetric(.federalTax)),
            .init(type: .keyMetric(.totalFICATax)),
        ]),
        .init(title: "Rates", items: [
            .init(type: .keyMetric(.averageTaxRate)),
            .init(type: .keyMetric(.effectiveTaxRate)),
            .init(type: .keyMetric(.provisionalTaxRate)),
        ])
    ])
}
