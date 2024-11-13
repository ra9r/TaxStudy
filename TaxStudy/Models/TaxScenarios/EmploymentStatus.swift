//
//  EmploymentStatus.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/13/24.
//

enum EmploymentStatus: String, Codable, CaseIterable {
    case employed
    case selfEmployed
    case retired
    case unemployed
}

extension EmploymentStatus: Displayable {
    var label: String {
        switch self {
        case .employed: return "Employed"
        case .selfEmployed: return "Self-Employed"
        case .retired: return "Retired"
        case .unemployed: return "Unemployed"
        }
    }
    
    var description: String? {
        switch self {
        case .employed: return "Employed"
        case .selfEmployed: return "Self-Employed"
        case .retired: return "Retired"
        case .unemployed: return "Unemployed"
        }
    }
    
    
}
