//
//  Profiles.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/19/24.
//
import SwiftUI

class Profile: Codable {
    var name: String
    var age: Int
    var employmentStatus: EmploymentStatus
    var wages: Double
    var socialSecurity: Double
    
    init(_ name: String, age: Int = 50, employmentStatus: EmploymentStatus = .retired, wages: Double = 0, socialSecurity: Double = 0) {
        self.name = name
        self.age = age
        self.employmentStatus = employmentStatus
        self.wages = wages
        self.socialSecurity = socialSecurity
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case age
        case employmentStatus
        case wages
        case socialSecurity
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.age = try container.decode(Int.self, forKey: .age)
        self.employmentStatus = try container.decode(EmploymentStatus.self, forKey: .employmentStatus)
        self.wages = try container.decode(Double.self, forKey: .wages)
        self.socialSecurity = try container.decode(Double.self, forKey: .socialSecurity)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(age, forKey: .age)
        try container.encode(employmentStatus, forKey: .employmentStatus)
        try container.encode(wages, forKey: .wages)
        try container.encode(socialSecurity, forKey: .socialSecurity)
    }
}

extension Profile: DeepCopyable {
    var deepCopy: Profile {
        let copy = Profile(
            name,
            age: age,
            employmentStatus: employmentStatus,
            wages: wages,
            socialSecurity: socialSecurity
        )
        return copy
    }
}
