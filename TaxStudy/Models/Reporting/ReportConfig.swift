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
    ], compareReport: [
        .init(title: "Summary", items: [
            KeyMetricReportItem(.filingStatus),
            KeyMetricReportItem(.grossIncome),
            KeyMetricReportItem(.totalIncome),
            KeyMetricReportItem(.agi),
            KeyMetricReportItem(.deduction),
            KeyMetricReportItem(.taxableIncome),
            KeyMetricReportItem(.amtIncome),
        ]),
        .init(title: "Taxes", items: [
            KeyMetricReportItem(.amtTax),
            KeyMetricReportItem(.federalTax),
            KeyMetricReportItem(.totalFICATax),
        ])
    ])
}
