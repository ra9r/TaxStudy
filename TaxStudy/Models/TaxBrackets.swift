//
//  TaxBrackets.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/1/24.
//

import Foundation
import SwiftData


class TaxBrackets : Codable, Identifiable {
   
    var id: String = UUID().uuidString
    var single: [TaxBracket] = []
    var marriedFilingJointly: [TaxBracket] = []
    var marriedFilingSeparately: [TaxBracket] = []
    var qualifiedWidow: [TaxBracket] = []
    var headOfHousehold: [TaxBracket] = []
    
    init(year: String? = nil,
         single: [TaxBracket] = [],
         marriedFilingJointly: [TaxBracket] = [],
         marriedFilingSeparately: [TaxBracket] = [],
         qualifiedWidow: [TaxBracket] = [],
         headOfHousehold: [TaxBracket] = []) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"  // Set the format to only get the year
        let currentYear = dateFormatter.string(from: .now)
        
        self.id = year ?? currentYear
        self.single = single
        self.marriedFilingJointly = marriedFilingJointly
        self.marriedFilingSeparately = marriedFilingSeparately
        self.qualifiedWidow = qualifiedWidow
        self.headOfHousehold = headOfHousehold
    }
    
    enum CodingKeys: String, CodingKey {
        case year
        case single
        case marriedFilingJointly
        case marriedFilingSeparately
        case qualifiedWidow
        case headOfHousehold
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .year)
        single = try container.decode([TaxBracket].self, forKey: .single)
        marriedFilingJointly = try container.decode([TaxBracket].self, forKey: .marriedFilingJointly)
        marriedFilingSeparately = try container.decode([TaxBracket].self, forKey: .marriedFilingSeparately)
        qualifiedWidow = try container.decode([TaxBracket].self, forKey: .qualifiedWidow)
        headOfHousehold = try container.decode([TaxBracket].self, forKey: .headOfHousehold)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .year)
        try container.encode(single, forKey: .single)
        try container.encode(marriedFilingJointly, forKey: .marriedFilingJointly)
        try container.encode(marriedFilingSeparately, forKey: .marriedFilingSeparately)
        try container.encode(qualifiedWidow, forKey: .qualifiedWidow)
        try container.encode(headOfHousehold, forKey: .headOfHousehold)
    }
    
    func brackets(for status: FilingStatus) -> [TaxBracket] {
        switch status {
        case .single: return single
        case .marriedFilingJointly: return marriedFilingJointly
        case .marriedFilingSeparately: return marriedFilingSeparately
        case .qualifiedWidow: return qualifiedWidow
        case .headOfHousehold: return headOfHousehold
        }
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
