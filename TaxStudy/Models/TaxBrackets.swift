//
//  TaxBrackets.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/1/24.
//

struct TaxBrackets : Codable {
    private var bracketForStatus: [FilingStatus: [TaxBracket]]
    
    init(_ brackets: [FilingStatus: [TaxBracket]] = [:]) {
        self.bracketForStatus = brackets
    }
    
    func brackets(for status: FilingStatus) -> [TaxBracket] {
        return bracketForStatus[status] ?? []
    }
    
    func highestRate(for amount: Double, filingAs filingStatus: FilingStatus) -> Double {
        // Sort the brackets by their threshold in ascending order
        let sortedBrackets = brackets(for: filingStatus).sorted { $0.threshold < $1.threshold }
        
        // Iterate through the sorted brackets to find the highest applicable rate
        var applicableRate: Double = 0
        
        for bracket in sortedBrackets {
            if amount >= bracket.threshold {
                applicableRate = bracket.rate
            } else {
                break
            }
        }
        
        return applicableRate
    }
    
    func progressiveTax(for income: Double, filingAs filingStatus: FilingStatus) -> Double {
        var ordinaryIncomeTax: Double = 0
        
        let sortedBrackets = brackets(for: filingStatus).sorted { $0.threshold < $1.threshold }

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
