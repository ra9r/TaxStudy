//
//  TaxScenario.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 9/27/24.
//

import Foundation
import SwiftData

@Observable
class TaxScenario: Codable, Identifiable {
    
    var id: String = UUID().uuidString
    var name: String
    var description: String = ""
    var filingStatus: FilingStatus = FilingStatus.single
    var facts: String
    var profileSelf: Profile
    var profileSpouse: Profile
    var income: IncomeSources = IncomeSources()
    var deductions: Deductions<TaxDeductionType> = Deductions()
    var credits: Deductions<TaxCreditType> = Deductions()
    var adjustments: Deductions<TaxAdjustmentType> = Deductions()
    
    init(name: String, filingStatus: FilingStatus = .single, profleSelf: Profile? = nil, profileSpouse: Profile? = nil, facts: String) {
        self.name = name
        self.filingStatus = filingStatus
        self.facts = facts 
        self.profileSelf = profleSelf ?? Profile("Taxpayer 1")
        self.profileSpouse = profileSpouse ?? Profile("Taxpayer 2")
    }
    
    // MARK: - Wages
    var wagesSelf: Double {
        profileSelf.wages
    }
    var wagesSpouse: Double {
        profileSpouse.wages
    }
    
    // MARK: - Social Security
    var socialSecuritySelf: Double {
        profileSelf.socialSecurity
    }
    var socialSecuritySpouse: Double {
        profileSpouse.socialSecurity
    }
    
    // MARK: - Investment Income
    var interest: Double {
        income.total(for: .interest)
    }
    var taxExemptInterest: Double {
        income.total(for: .taxExemptInterest)
    }
    
    var longTermCapitalGains: Double {
        income.total(for: .longTermCapitalGains)
    }
    var carryforwardLoss: Double {
        income.total(for: .carryforwardLoss)
    }
    
    var shortTermCapitalGains: Double {
        income.total(for: .shortTermCapitalGains)
    }
    
    var qualifiedDividends: Double {
        income.total(for: .qualifiedDividends)
    }
    
    var ordinaryDividends: Double {
        return income.total(for: .ordinaryDividends)
    }
    
    var totalDividends: Double {
        ordinaryDividends + qualifiedDividends
    }
    
    // MARK: - Misc Income
    var rentalIncome: Double {
        return income.total(for: .rentalIncome)
    }
    var royalties: Double {
        return income.total(for: .royalties)
    }
    var businessIncome: Double {
        return income.total(for: .businessIncome)
    }
    var foreignEarnedIncome: Double {
        return income.total(for: .foreignEarnedIncome)
    }
    
    // MARK: - Retirement
    
    var iraWithdrawal: Double {
        return income.total(for: .iraWithdrawal)
    }
    var rothConversion: Double {
        return income.total(for: .rothConversion)
    }
    
    
    // MARK: - Other Excluded Income
    var qualifiedHSADistributions: Double {
        return income.total(for: .qualifiedHSADistributions)
    }
    var rothDistributions: Double {
        return income.total(for: .rothDistributions)
    }
    var giftsOrInheritance: Double {
        return income.total(for: .giftsOrInheritance)
    }
    var otherTaxExemptIncome: Double {
        return income.total(for: .otherTaxExemptIncome)
    }
    
    // MARK: - Adjustments (for AGI)
    var hsaContribution: Double {
        return adjustments.total(for: .hsaContribution)
    }
    
    var iraContribtuion: Double {
        return adjustments.total(for: .iraOr401kContribution)
    }
    
    var studentLoanInterest: Double {
        return adjustments.total(for: .studentLoanInterest)
    }
    
    var businessExpenses: Double {
        return adjustments.total(for: .businessExpenses)
    }
    
    var earlyWithdrawalPenalties: Double {
        return adjustments.total(for: .earlyWithDrawalPenalties)
    }
    
    var foreignEarnedIncomeAndHousing: Double {
        return adjustments.total(for: .foreignEarnedIncomeExclusion) + adjustments.total(for: .foreignHousingExclusion)
    }
    
    var totalAdjustments: Double {
        return hsaContribution +
        iraContribtuion +
        studentLoanInterest +
        businessExpenses +
        earlyWithdrawalPenalties +
        foreignEarnedIncomeAndHousing
    }
    
    // MARK: - Wages and Social Security
    var totalWages: Double {
        if filingStatus == .marriedFilingJointly {
            return wagesSelf + wagesSpouse
        }
        return wagesSelf
    }
    
    var totalSocialSecurityIncome: Double {
        if filingStatus == .marriedFilingJointly {
            return socialSecuritySelf + socialSecuritySpouse
        }
        return socialSecuritySelf
    }
    
    // MARK: - Codable
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case filingStatus
        case employmentStatus
        case profileSelf
        case profileSpouse
        
        case income
        case deductions
        case credits
        case adjustments
        
        case facts
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
        filingStatus = try container.decode(FilingStatus.self, forKey: .filingStatus)
        profileSelf = try container.decode(Profile.self, forKey: .profileSelf)
        profileSpouse = try container.decode(Profile.self, forKey: .profileSpouse)
        facts = try container.decode(String.self, forKey: .facts)
        income = try container.decodeIfPresent(IncomeSources.self, forKey: .income) ?? IncomeSources()
        credits = try container.decodeIfPresent(Deductions<TaxCreditType>.self, forKey: .credits) ?? Deductions()
        deductions = try container.decodeIfPresent(Deductions<TaxDeductionType>.self, forKey: .deductions) ?? Deductions()
        adjustments = try container.decodeIfPresent(Deductions<TaxAdjustmentType>.self, forKey: .adjustments) ?? Deductions()
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(description, forKey: .description)
        try container.encode(filingStatus, forKey: .filingStatus)
        try container.encode(profileSelf, forKey: .profileSelf)
        try container.encode(profileSpouse, forKey: .profileSpouse)
        try container.encode(facts, forKey: .facts)

        try container.encode(income, forKey: .income)
        try container.encode(credits, forKey: .credits)
        try container.encode(deductions, forKey: .deductions)
        try container.encode(adjustments, forKey: .adjustments)
    }
}

// MARK: - Hashable
extension TaxScenario : Hashable {
    // Conforming to Hashable
    static func == (lhs: TaxScenario, rhs: TaxScenario) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension TaxScenario : DeepCopyable {
    var deepCopy: TaxScenario {
        let copy = TaxScenario(
            name: "\(name) Copy",
            filingStatus: filingStatus,
            profleSelf: profileSelf.deepCopy,
            profileSpouse: profileSpouse.deepCopy,
            facts: facts)
        
        copy.income = income.deepCopy
        copy.deductions = deductions.deepCopy
        copy.credits = credits.deepCopy
        copy.adjustments = adjustments.deepCopy
        return copy
    }
}
