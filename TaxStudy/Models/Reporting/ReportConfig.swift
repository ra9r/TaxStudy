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
            .keyMetric(.grossIncome),
            .keyMetric(.totalIncome),
            .keyMetric(.agi),
            .keyMetric(.deduction),
            .keyMetric(.taxableIncome),
            .keyMetric(.amtIncome),
            .keyMetric(.amtTax),
            .keyMetric(.federalTax),
            .keyMetric(.totalFICATax),
        ]),
        .init(title: "Column Middle", items: [
            .keyMetric(.filingStatus),
            .keyMetric(.marginalOrdinaryTaxRate),
            .keyMetric(.marginalCapitalGainsTaxRate),
            .keyMetric(.averageTaxRate),
            .divider,
            .keyMetric(.safeHarborTax),
            .keyMetric(.irmaaSurcharges),
            .keyMetric(.deductibleMedicalExpenses),
            .keyMetric(.deductibleMedicalExpensesForAMT),
        ]),
        .init(title: "Column Right", items: [
            .keyMetric(.totalTaxExemptInterestIncome),
            .keyMetric(.dividends),
            .keyMetric(.capitalGains),
            .keyMetric(.futureCarryForwardLoss),
            .keyMetric(.provisionalIncome),
            .keyMetric(.totalSSAIncome),
        ])
    ], compareReport: [
        .init(title: "Summary", items: [
            .keyMetric(.filingStatus),
            .keyMetric(.grossIncome),
            .keyMetric(.totalIncome),
            .keyMetric(.agi),
            .keyMetric(.deduction),
            .keyMetric(.taxableIncome),
            .keyMetric(.amtIncome),
        ]),
        .init(title: "Taxes", items: [
            .keyMetric(.amtTax),
            .keyMetric(.federalTax),
            .keyMetric(.totalFICATax),
        ])
    ])
}
