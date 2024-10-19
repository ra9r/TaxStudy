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
    var threshold: Double
    
    init(_ threshold: Double, _ rate: Double) {
        self.rate = rate
        self.threshold = threshold
    }
}

class TaxBrackets : Codable {
   
    var brackets: [TaxBracket] = []
    
    init(_ brackets: TaxBracket...) {
        self.brackets = brackets.sorted { $0.threshold < $1.threshold }
    }
    
    func highestBracket(for amount: Double) -> TaxBracket? {
        // Sort the brackets by their threshold in ascending order
        let sortedBrackets = brackets
        
        // Iterate through the sorted brackets to find the highest applicable rate
        var applicableBracket: TaxBracket?
        
        for bracket in sortedBrackets {
            if amount >= bracket.threshold {
                applicableBracket = bracket
            } else {
                break
            }
        }
        
        return applicableBracket
    }
    
    func progressiveTax(for income: Double) -> Double {
        var ordinaryIncomeTax: Double = 0
        
        let sortedBrackets = brackets
        
        for (i, bracket) in sortedBrackets.enumerated() {
            if income > bracket.threshold {
                let nextThreshold = i + 1 < sortedBrackets.count ? sortedBrackets[i + 1].threshold : income
                let taxableAtRate = min(income, nextThreshold) - bracket.threshold
                ordinaryIncomeTax += taxableAtRate * bracket.rate
            } else {
                break
            }
        }
        
        return ordinaryIncomeTax
    }
}

