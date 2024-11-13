//
//  FilingStatus.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/1/24.
//

enum FilingStatus : String, Codable, CaseIterable {
    case single
    case marriedFilingJointly
    case marriedFilingSeparately
    case qualifiedWidow
    case headOfHousehold
    
    var symbol: String {
        switch self {
        case .single:
            return "person"
        case .marriedFilingJointly:
            return "person.2"
        case .marriedFilingSeparately:
            return "person.crop.circle.badge.xmark"
        case .qualifiedWidow:
            return "person.2.and.child"
        case .headOfHousehold:
            return "house"
        }
    }
}
 
extension FilingStatus : Displayable {
    var description: String? {
        switch self {
        case .single:
            return String(localized: "Filing as an individual tax payer")
        case .marriedFilingJointly:
            return String(localized: "Filing together as a married couple")
        case .marriedFilingSeparately:
            return String(localized: "Filing separately as a married couple")
        case .qualifiedWidow:
            return String(localized: "Filing as a qualified widow or widower")
        case .headOfHousehold:
            return String(localized: "Filing as the head of household")
        }
    }
    
    var label: String {
        switch self {
        case .single:
            return String(localized: "Single")
        case .marriedFilingJointly:
            return String(localized: "Married Filing Jointly")
        case .marriedFilingSeparately:
            return String(localized: "Married Filing Separately")
        case .qualifiedWidow:
            return String(localized: "Qualified Widow(er)")
        case .headOfHousehold:
            return String(localized: "Head of Household")
        }
    }
}
