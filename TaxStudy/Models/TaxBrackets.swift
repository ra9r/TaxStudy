//
//  TaxBrackets.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/1/24.
//

import Foundation
import SwiftData

struct TaxBracket : Codable, Identifiable {
    var id: Double {
        return rate
    }

    var rate: Double
    var thresholds: [FilingStatus: Double]
    
    init(_ rate: Double, thresholds: [FilingStatus: Double]) {
        self.rate = rate
        self.thresholds = thresholds
    }
    
    func threshold(for filingStatus: FilingStatus) throws -> Double {
        guard let threshold = thresholds[filingStatus] else {
            throw AppErrors.missingFilingStatus(String(localized: "Threshold not defined for \(rate.asPercentage) and '\(filingStatus.label)'"))
        }
        
        return threshold
    }
}

class TaxBrackets : Codable {
   
    var brackets: [TaxBracket] = []
    
    init(_ brackets: TaxBracket..., ascending: Bool = true) {
        if ascending {
            self.brackets = brackets.sorted { $0.rate < $1.rate }
        } else {
            self.brackets = brackets.sorted { $0.rate > $1.rate }
        }
        
    }
    
    func highestBracket(for amount: Double, filingStatus: FilingStatus) throws -> TaxBracket {
        // Iterate through the sorted brackets to find the highest applicable rate
        var applicableBracket: TaxBracket?
        
        for bracket in brackets {
            let threshold = try bracket.threshold(for: filingStatus)
            if amount >= threshold {
                applicableBracket = bracket
            } else {
                break
            }
        }
        if let applicableBracket {
            return applicableBracket
        }
        
        throw AppErrors.missingFilingStatus(String(localized: "No applicable tax bracket found for \(amount.asCurrency) and '\(filingStatus.label)'"))
    }
    
    func progressiveTax(for income: Double, filingStatus: FilingStatus) throws -> Double {
        var computedTax: Double = 0
        
        for (i, bracket) in brackets.enumerated() {
            let threshold = try bracket.threshold(for: filingStatus)
            if income > threshold {
                var nextThreshold = income
                if (i + 1 < brackets.count) {
                    nextThreshold = try brackets[i + 1].threshold(for: filingStatus)
                }
                let taxableAtRate = min(income, nextThreshold) - threshold
                computedTax += taxableAtRate * bracket.rate
            } else {
                break
            }
        }
        
        return computedTax
    }
}

let OrdinaryTaxBrackets2024 = TaxBrackets(
    .init(0.10, thresholds: [
        .single: 0,
        .marriedFilingJointly: 0,
        .marriedFilingSeparately: 0,
        .headOfHousehold: 0,
        .qualifiedWidow: 0
    ]),
    .init(0.12, thresholds: [
        .single: 11_600,
        .marriedFilingJointly: 23_201,
        .marriedFilingSeparately: 0,
        .headOfHousehold: 16_550,
        .qualifiedWidow: 0
    ]),
    .init(0.22, thresholds: [
        .single: 47_150,
        .marriedFilingJointly: 94_301,
        .marriedFilingSeparately: 0,
        .headOfHousehold: 63_101,
        .qualifiedWidow: 0
    ]),
    .init(0.24, thresholds: [
        .single: 100_525,
        .marriedFilingJointly: 201_051,
        .marriedFilingSeparately: 0,
        .headOfHousehold: 100_501,
        .qualifiedWidow: 0
    ]),
    .init(0.32, thresholds: [
        .single: 191_950,
        .marriedFilingJointly: 383_901,
        .marriedFilingSeparately: 0,
        .headOfHousehold: 191_951,
        .qualifiedWidow: 0
    ]),
    .init(0.35, thresholds: [
        .single: 234_726,
        .marriedFilingJointly: 487_451,
        .marriedFilingSeparately: 0,
        .headOfHousehold: 243_701,
        .qualifiedWidow: 0
    ]),
    .init(0.37, thresholds: [
        .single: 609_351,
        .marriedFilingJointly: 731_201,
        .marriedFilingSeparately: 0,
        .headOfHousehold: 609_351,
        .qualifiedWidow: 0
    ])
)

let CapitalGainTaxBrackets2024 = TaxBrackets(
    .init(0.0, thresholds: [
        .single: 0,
        .marriedFilingJointly: 0,
        .marriedFilingSeparately: 0,
        .headOfHousehold: 0,
        .qualifiedWidow: 0
    ]),
    .init(0.15, thresholds: [
        .single: 47_026,
        .marriedFilingJointly: 94_051,
        .marriedFilingSeparately: 0,
        .headOfHousehold: 63_001,
        .qualifiedWidow: 0
    ]),
    .init(0.20, thresholds: [
        .single: 518_901,
        .marriedFilingJointly: 583_751,
        .marriedFilingSeparately: 0,
        .headOfHousehold: 551_351,
        .qualifiedWidow: 0
    ])
)

let SSTaxThresholds2024 = TaxBrackets(
    .init(0.062, thresholds: [
        .single: 0,
        .marriedFilingJointly: 0,
        .marriedFilingSeparately: 0,
        .headOfHousehold: 0,
        .qualifiedWidow: 0
    ]),
    .init(0.0, thresholds: [
        .single: 168_600,
        .marriedFilingJointly: 168_600,
        .marriedFilingSeparately: 168_600,
        .headOfHousehold: 168_600,
        .qualifiedWidow: 168_600
    ]),
    ascending: false
)

let MedicareTaxThresholds2024 = TaxBrackets(
    .init(0.029, thresholds: [
        .single: 0,
        .marriedFilingJointly: 0,
        .marriedFilingSeparately: 0,
        .headOfHousehold: 0,
        .qualifiedWidow: 0
    ]),
    .init(0.009, thresholds: [
        .single: 200_000,
        .marriedFilingJointly: 250_000,
        .marriedFilingSeparately: 125_000,
        .headOfHousehold: 200_000,
        .qualifiedWidow: 200_000
    ]),
    ascending: false
)

let ProvisionalIncomeThresholds2024 = TaxBrackets(
    .init(0.0, thresholds: [
        .single: 0,
        .marriedFilingJointly: 0,
        .marriedFilingSeparately: 0,
        .headOfHousehold: 0,
        .qualifiedWidow: 0
    ]),
    .init(0.5, thresholds: [
        .single: 25_000,
        .marriedFilingJointly: 32_000,
        .marriedFilingSeparately: 25_000,
        .headOfHousehold: 25_000,
        .qualifiedWidow: 32_000
    ]),
    .init(0.85, thresholds: [
        .single: 34_000,
        .marriedFilingJointly: 44_000,
        .marriedFilingSeparately: 34_000,
        .headOfHousehold: 34_000,
        .qualifiedWidow: 44_000
    ])
)

let PlanBSurchargethresholds2024 = TaxBrackets(
    .init(0.0, thresholds: [
        .single: 0,
        .marriedFilingJointly: 0
    ]),
    .init(70.0, thresholds: [
        .single: 103000,
        .marriedFilingJointly: 206000
    ]),
    .init(175.0, thresholds: [
        .single: 123000,
        .marriedFilingJointly: 246000
    ]),
    .init(280.0, thresholds: [
        .single: 153000,
        .marriedFilingJointly: 306000
    ]),
    .init(285, thresholds: [
        .single: 183000,
        .marriedFilingJointly: 366000
    ]),
    .init(280.0, thresholds: [
        .single: 500000,
        .marriedFilingJointly: 750000
    ])
)

let PlanDSurchargethresholds2024 = TaxBrackets(
    .init(0.0, thresholds: [
        .single: 0,
        .marriedFilingJointly: 0
    ]),
    .init(12.0, thresholds: [
        .single: 103000,
        .marriedFilingJointly: 206000
    ]),
    .init(31.0, thresholds: [
        .single: 123000,
        .marriedFilingJointly: 246000
    ]),
    .init(50.0, thresholds: [
        .single: 153000,
        .marriedFilingJointly: 306000
    ]),
    .init(70.0, thresholds: [
        .single: 183000,
        .marriedFilingJointly: 366000
    ]),
    .init(76.0, thresholds: [
        .single: 500000,
        .marriedFilingJointly: 750000
    ])
)
