//
//  FilingStatus.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/1/24.
//

enum FilingStatus : String, Codable, CaseIterable {
    case single = "Single"
    case marriedFilingJointly = "Married Filing Jointly"
    case marriedFilingSeparately = "Married Filing Separately"
    case qualifiedWidow = "Qualified Widow(er)"
    case qualifiedWidowWithChild = "Qualified Widow(er) with Child"
    case headOfHousehold = "Head of Household"
    
    var symbol: String {
        switch self {
        case .single:
            return "person"
        case .marriedFilingJointly:
            return "person.2"
        case .marriedFilingSeparately:
            return "person.crop.circle.badge.xmark"
        case .qualifiedWidow:
            return "person.2.fill"
        case .qualifiedWidowWithChild:
            return "person.2.and.child"
        case .headOfHousehold:
            return "house"
        }
    }
}
