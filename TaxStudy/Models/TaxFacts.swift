//
//  TaxFacts.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/13/24.
//

import Foundation

/// Collection of tax brackets and other contraints and limits that are used in computing the taxes for a given year.
class TaxFacts : Codable, Identifiable {
    var id: String = UUID().uuidString
    var ordinaryTaxBrackets: [FilingStatus: TaxBrackets]
    var capitalGainTaxBrackets: [FilingStatus: TaxBrackets]
    var ssTaxThresholds: [FilingStatus: TaxBrackets]
    var medicareTaxThresholds: [FilingStatus: TaxBrackets]
    var provisionalIncomeThresholds: [FilingStatus: TaxBrackets]
    var niitThresholds: [FilingStatus: Double]
    var niitRate: Double
    var capitalLossLimit: Double // 3000
    var standardDeduction: [FilingStatus: Double] // 14600 in 2023 standard deduction for single filers
    var ssdiThreshold: Double // 34000
    
    init(
        ordinaryTaxBrackets: [FilingStatus : TaxBrackets],
        capitalGainTaxBrackets: [FilingStatus : TaxBrackets],
        ssTaxThresholds: [FilingStatus : TaxBrackets],
        medicareTaxThresholds: [FilingStatus : TaxBrackets],
        provisionalIncomeThresholds: [FilingStatus: TaxBrackets],
        niitThresholds: [FilingStatus : Double],
        niitRate: Double,
        standardDeduction: [FilingStatus : Double],
        capitalLossLimit: Double,
        ssdiThreshold: Double
    ) {
        self.ordinaryTaxBrackets = ordinaryTaxBrackets
        self.capitalGainTaxBrackets = capitalGainTaxBrackets
        self.ssTaxThresholds = ssTaxThresholds
        self.medicareTaxThresholds = medicareTaxThresholds
        self.provisionalIncomeThresholds = provisionalIncomeThresholds
        self.niitThresholds = niitThresholds
        self.niitRate = niitRate
        self.capitalLossLimit = capitalLossLimit
        self.standardDeduction = standardDeduction
        self.ssdiThreshold = ssdiThreshold
    }
}

let DefaultTaxFacts2024 = TaxFacts(
    ordinaryTaxBrackets: [
        .single: TaxBrackets(
            .init(0, 0.10),
            .init(11_600, 0.12),
            .init(47_150, 0.22),
            .init(100_525, 0.24),
            .init(191_950, 0.32),
            .init(234_726, 0.035),
            .init(609_351, 0.37)),
        .marriedFilingJointly: TaxBrackets(
            .init(0, 0.10),
            .init(23_201, 0.12),
            .init(94_301, 0.22),
            .init(201_051, 0.24),
            .init(383_901, 0.32),
            .init(487_451, 0.035),
            .init(731_201, 0.37)),
        .headOfHousehold: TaxBrackets(
            .init(0, 0.10),
            .init(16_550, 0.12),
            .init(63_101, 0.22),
            .init(100_501, 0.24),
            .init(191_951, 0.32),
            .init(243_701, 0.035),
            .init(609_351, 0.37))
    ],
    capitalGainTaxBrackets: [
        .single: TaxBrackets(
            .init(0, 0.10),
            .init(47_026, 0.15),
            .init(518_901, 0.20)),
        .marriedFilingJointly: TaxBrackets(
            .init(0, 0.10),
            .init(94051, 0.15),
            .init(583751, 0.20)),
        .headOfHousehold: TaxBrackets(
            .init(0, 0.10),
            .init(63_001, 0.15),
            .init(551_351, 0.20))
    ],
    ssTaxThresholds: [
        .single: TaxBrackets(
            .init(0, 0.062),
            .init(160_200, 0.0)),
        .marriedFilingJointly: TaxBrackets(
            .init(0, 0.062),
            .init(160_200, 0.0)),
        .headOfHousehold: TaxBrackets(
            .init(0, 0.062),
            .init(160_200, 0.0))
    ],
    medicareTaxThresholds: [
        .single: TaxBrackets(
            .init(0, 0.045),
            .init(200_000, 0.009)),
        .marriedFilingJointly: TaxBrackets(
            .init(0, 0.045),
            .init(250_000, 0.009)),
        .marriedFilingSeparately: TaxBrackets(
            .init(0, 0.045),
            .init(125_000, 0.009)),
        .headOfHousehold: TaxBrackets(
            .init(0, 0.045),
            .init(200_000, 0.009))
    ],
    provisionalIncomeThresholds: [
        .single: TaxBrackets(
            .init(0, 0.0),
            .init(25_000, 0.5),
            .init(34_000, 0.85)),
        .marriedFilingJointly: TaxBrackets(
            .init(0, 0.0),
            .init(32_000, 0.5),
            .init(44_000, 0.85)),
        .marriedFilingSeparately: TaxBrackets(
            .init(0, 0.85)),
        .headOfHousehold: TaxBrackets(
            .init(0, 0.0),
            .init(25_000, 0.5),
            .init(34_000, 0.85)),
    ],
    niitThresholds: [
        .single: 200_000,
        .marriedFilingJointly: 250_000,
        .marriedFilingSeparately: 125_000,
        .headOfHousehold: 200_000,
        .qualifiedWidow: 250_000
    ],
    niitRate: 0.038,
    standardDeduction: [
        .single: 14_600,
        .marriedFilingJointly: 29_200,
        .qualifiedWidow: 29_200,
        .headOfHousehold: 21_900
    ],
    capitalLossLimit: 3000,
    ssdiThreshold: 34000
)
