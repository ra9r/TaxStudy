//
//  TaxBrackets.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/1/24.
//

import Foundation
import SwiftData





@Observable
class TaxBrackets : Codable, Identifiable {
    
    var id: UUID = UUID()
    
    var brackets: [TaxBracket] = []
    
    init(_ brackets: TaxBracket..., ascending: Bool = true) {
        if ascending {
            self.brackets = brackets.sorted { $0.rate < $1.rate }
        } else {
            self.brackets = brackets.sorted { $0.rate > $1.rate }
        }
    }
    
    init(_ brackets: [TaxBracket]) {
        self.brackets = brackets
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

    func progressiveTaxParts(for income: Double, filingStatus: FilingStatus) throws -> [ProgressiveTaxPart] {
        var txParts: [ProgressiveTaxPart] = []
        
        for (i, bracket) in brackets.enumerated() {
            var txPart = ProgressiveTaxPart()
            txPart.rate = bracket.rate
            txPart.threshold = try bracket.threshold(for: filingStatus)
            if income > txPart.threshold {
                var nextThreshold = income
                if (i + 1 < brackets.count) {
                    nextThreshold = try brackets[i + 1].threshold(for: filingStatus)
                }
                txPart.taxableAtRate = min(income, nextThreshold) - txPart.threshold
                txPart.computedTax = txPart.taxableAtRate * bracket.rate
                txParts.append(txPart)
            } else {
                break
            }
        }
        
        return txParts
    }
    
    func progressiveTax(for income: Double, filingStatus: FilingStatus) throws -> Double {
        let txParts = try progressiveTaxParts(for: income, filingStatus: filingStatus)
        
        return txParts.reduce(0) { partialResult, txPart in
            return partialResult + txPart.computedTax
        }
    }
    
    // Custom Encodable conformance
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(brackets)
    }
    
    // Custom Decodable conformance
    required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.brackets = try container.decode([TaxBracket].self)
    }
}

extension TaxBrackets : Hashable {
    static func == (lhs: TaxBrackets, rhs: TaxBrackets) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension TaxBrackets : DeepCopyable {
    var deepCopy: TaxBrackets {
        let copiedBrackets = self.brackets.map { $0.deepCopy }
        return TaxBrackets(copiedBrackets)
    }
}

struct ProgressiveTaxPart : Codable {
    var rate: Double
    var threshold: Double
    var taxableAtRate: Double
    var computedTax: Double
    
    init(rate: Double = 0, threshold: Double = 0, taxableAtRate: Double = 0, computedTax: Double = 0) {
        self.rate = rate
        self.threshold = threshold
        self.taxableAtRate = taxableAtRate
        self.computedTax = computedTax
    }
}
