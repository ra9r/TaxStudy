//
//  EmploymentStatus.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/13/24.
//

enum EmploymentStatus: String, Codable, CaseIterable {
    case employed = "Employeed"
    case selfEmployed = "Self-Employed"
    case retired = "Retired"
    case unemployed = "Unemployed"
}
