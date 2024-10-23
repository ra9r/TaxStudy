//
//  Profiles.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/19/24.
//
import SwiftUI

enum MedicalCoverageTypes: String, Codable, CaseIterable, Displayable {
    case medicare
    case medicaide
    case marketplaceACAPlan
    case offMarketACAPlan
    case otherOrNone
    
    var label: String {
        switch self {
        case .medicare:
            return String(localized: "Medicare")
        case .medicaide:
            return String(localized: "Medicaid")
        case .marketplaceACAPlan:
            return String(localized: "ACA Market Plan")
        case .offMarketACAPlan:
            return String(localized: "ACA Off-Market Plan")
        case .otherOrNone:
            return String(localized: "Other/None")
        }
    }
    
    var description: String {
        switch self {
        case .medicare:
            return String(localized: "Individual is able to use Medicare benefits")
        case .medicaide:
            return String(localized: "Individual is receiving Medicaid benefits")
        case .marketplaceACAPlan:
            return String(localized: "Individual is using ACA Plan purchase from the Marketplace which provide subsidies for qualified individuals")
        case .offMarketACAPlan:
            return String(localized: "Individual is using off-market ACA Plans which do not provide subsidies")
        case .otherOrNone:
            return String(localized: "Individual is may be using other insurance (Corporate, Private, ACA Marketplace, or Nothing")
        }
    }
}

class Profile: Codable {
    var name: String
    var age: Int
    var employmentStatus: EmploymentStatus
    var wages: Double
    var socialSecurity: Double
    var medicalCoverage: MedicalCoverageTypes
    
    init(_ name: String, age: Int = 50, employmentStatus: EmploymentStatus = .retired, wages: Double = 0, socialSecurity: Double = 0, medicalCoverage: MedicalCoverageTypes = .otherOrNone) {
        self.name = name
        self.age = age
        self.employmentStatus = employmentStatus
        self.wages = wages
        self.socialSecurity = socialSecurity
        self.medicalCoverage = medicalCoverage
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case age
        case employmentStatus
        case wages
        case socialSecurity
        case medicalCoverage
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.age = try container.decode(Int.self, forKey: .age)
        self.employmentStatus = try container.decode(EmploymentStatus.self, forKey: .employmentStatus)
        self.wages = try container.decodeIfPresent(Double.self, forKey: .wages) ?? 0
        self.socialSecurity = try container.decodeIfPresent(Double.self, forKey: .socialSecurity) ?? 0
        self.medicalCoverage = try container.decodeIfPresent(MedicalCoverageTypes.self, forKey: .medicalCoverage) ?? .otherOrNone
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(age, forKey: .age)
        try container.encode(employmentStatus, forKey: .employmentStatus)
        try container.encode(wages, forKey: .wages)
        try container.encode(socialSecurity, forKey: .socialSecurity)
        try container.encode(medicalCoverage, forKey: .medicalCoverage)
    }
}

extension Profile: DeepCopyable {
    var deepCopy: Profile {
        let copy = Profile(
            name,
            age: age,
            employmentStatus: employmentStatus,
            wages: wages,
            socialSecurity: socialSecurity,
            medicalCoverage: medicalCoverage
        )
        return copy
    }
}
