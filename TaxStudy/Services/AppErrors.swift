//
//  AppErrors.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/20/24.
//
import SwiftUI

enum AppErrors: LocalizedError {
    case missingFilingStatus(String)
    case unknownTaxFact(String)
    
    var errorDescription: String? {
        switch self {
        case .missingFilingStatus(let filingStatus):
            return "Missing filing status: \(filingStatus)"
        case .unknownTaxFact(let taxFact):
            return "Unknown tax fact: \(taxFact)"
        }
    }
}
