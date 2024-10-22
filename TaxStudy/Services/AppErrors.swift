//
//  AppErrors.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/20/24.
//

enum AppErrors: Error {
    case missingFilingStatus(String)
    case unknownTaxFact(String)
}
