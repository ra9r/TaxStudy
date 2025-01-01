//
//  TaxBracket.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/26/24.
//

import Foundation


class TaxBracket : Codable, Identifiable {
    static func == (lhs: TaxBracket, rhs: TaxBracket) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id: UUID = UUID()
    
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
    
extension TaxBracket: DeepCopyable {
    var deepCopy: TaxBracket {
        return TaxBracket(self.rate, thresholds: self.thresholds)
    }
}

extension TaxBracket: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
