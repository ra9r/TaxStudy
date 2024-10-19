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
    var employmentStatus: EmploymentStatus = .retired
    var income: IncomeSources = IncomeSources()
    var deductions: Deductions<TaxDeductionType> = Deductions()
    var credits: Deductions<TaxCreditType> = Deductions()
    var adjustments: Deductions<TaxAdjustmentType> = Deductions()
    var facts: String
    var ageSelf: Int = 50
    var ageSpouce: Int = 50
    
    init(name: String, filingStatus: FilingStatus = .single, employmentStatus: EmploymentStatus = .retired, ageSelf: Int = 50, ageSpouce: Int = 50, facts: TaxFacts? = nil) {
        self.name = name
        self.filingStatus = filingStatus
        self.employmentStatus = employmentStatus
        self.ageSelf = ageSelf
        self.ageSpouce = ageSpouce
        self.facts = facts?.id ?? DefaultTaxFacts2024.id
    }
    
    // MARK: - Wages
    var wagesSelf: Double {
        income.total(for: .wagesSelf)
    }
    var wagesSpouse: Double {
        income.total(for: .wagesSpouse)
    }
    
    // MARK: - Social Security
    var socialSecuritySelf: Double {
        income.total(for: .socialSecuritySelf)
    }
    var socialSecuritySpouse: Double {
        income.total(for: .socialSecuritySpouse)
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
        return wagesSelf + wagesSpouse
    }
    
    var totalSocialSecurityIncome: Double {
        return socialSecuritySelf + socialSecuritySpouse
    }
    
    // MARK: - Codable
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case filingStatus
        case employmentStatus
        
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
        employmentStatus = try container.decode(EmploymentStatus.self, forKey: .employmentStatus)
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
        try container.encode(employmentStatus, forKey: .employmentStatus)
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
