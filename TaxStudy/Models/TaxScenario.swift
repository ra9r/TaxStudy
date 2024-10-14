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
    
    init(name: String, filingStatus: FilingStatus = .single, employmentStatus: EmploymentStatus = .retired) {
        self.name = name
        self.filingStatus = filingStatus
        self.employmentStatus = employmentStatus
    }
    
    // MARK: - Wages
    var wagesSelf: Double = 0
    var wagesSpouse: Double = 0
    
    // MARK: - Social Security
    var socialSecuritySelf: Double = 0
    var socialSecuritySpouse: Double = 0
    
    // MARK: - Investment Income
    var interest: Double = 0
    var taxExemptInterest: Double = 0
    
    var longTermCapitalGains: Double = 0
    var longTermCapitalLosses: Double = 0
    var capitalLossCarryOver: Double = 0
    
    var shortTermCapitalGains: Double = 0
    var shortTermCapitalLosses: Double = 0
    
    var qualifiedDividends: Double = 0
    var nonQualifiedDividends: Double = 0
    
    // MARK: - Misc Income
    var rentalIncome: Double = 0
    var royalties: Double = 0
    var businessIncome: Double = 0
    var foreignEarnedIncome: Double = 0
    
    // MARK: - Retirement
    var hsaContribution: Double = 0
    var iraContribtuion: Double = 0
    var iraWithdrawal: Double = 0
    var rothConversion: Double = 0
    
    // MARK: - Deductions
    var marginInterestExpense: Double = 0
    var mortgageInterestExpense: Double = 0
    var medicalAndDentalExpense: Double = 0
    var charitableContributions: Double = 0
    var dafContributions: Double = 0
    
    // MARK: - Computed Values
    var grossIncome: Double {
        return federalTaxes.grossIncome
    }
    
    var totalWages: Double {
        return wagesSelf + wagesSpouse
    }
    
    var totalSocialSecurityIncome: Double {
        return socialSecuritySelf + socialSecuritySpouse
    }
    
    var afterTaxIncome: Double {
        return grossIncome - federalTaxes.taxesOwed - stateTaxes.taxesOwed
    }
    
    var totalTaxesOwed: Double {
        return federalTaxes.taxesOwed + stateTaxes.taxesOwed
    }
    
    var totalEffectiveTaxRate: Double {
        if grossIncome == 0 {
            return 0
        }
        return totalTaxesOwed / grossIncome
    }
    
    // MARK: - Helper Classes
    @Transient
    var facts: TaxFacts = TaxFacts2024
    
    @Transient
    var federalTaxes: FederalTaxCalc {
        return FederalTaxCalc(self)
    }
    
    @Transient
    var stateTaxes: StateTaxCalc {
        return NCTaxCalc(federalTaxes)
    }
    
    // MARK: - Codable
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case filingStatus
        case employmentStatus
        // Wages
        case wagesSelf
        case wagesSpouse
        // Social Security Income
        case socialSecuritySelf
        case socialSecuritySpouse
        // Investment Income
        case interest
        case taxExemptInterest

        case longTermCapitalGains
        case longTermCapitalLosses
        case capitalLossCarryOver

        case shortTermCapitalGains
        case shortTermCapitalLosses

        case qualifiedDividends
        case nonQualifiedDividends
        // Misc Income
        case rentalIncome
        case royalties
        case businessIncome
        case foreignEarnedIncome
        // Retirement
        case hsaContribution
        case iraContribtuion
        case iraWithdrawal
        case rothConversion
        // Deductions
        case marginInterestExpense
        case mortgageInterestExpense
        case medicalAndDentalExpense
        case charitableContributions
        case dafContributions
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
        filingStatus = try container.decodeIfPresent(FilingStatus.self, forKey: .filingStatus) ?? .single
        employmentStatus = try container.decodeIfPresent(EmploymentStatus.self, forKey: .employmentStatus) ?? .retired
        
        wagesSelf = try container.decodeIfPresent(Double.self, forKey: .wagesSelf) ?? 0
        wagesSpouse = try container.decodeIfPresent(Double.self, forKey: .wagesSpouse) ?? 0
        
        socialSecuritySelf = try container.decodeIfPresent(Double.self, forKey: .socialSecuritySelf) ?? 0
        socialSecuritySpouse = try container.decodeIfPresent(Double.self, forKey: .socialSecuritySpouse) ?? 0
        
        interest = try container.decodeIfPresent(Double.self, forKey: .interest) ?? 0
        taxExemptInterest = try container.decodeIfPresent(Double.self, forKey: .taxExemptInterest) ?? 0
        
        longTermCapitalGains = try container.decodeIfPresent(Double.self, forKey: .longTermCapitalGains) ?? 0
        longTermCapitalLosses = try container.decodeIfPresent(Double.self, forKey: .longTermCapitalLosses) ?? 0
        capitalLossCarryOver = try container.decodeIfPresent(Double.self, forKey: .capitalLossCarryOver) ?? 0
        
        shortTermCapitalGains = try container.decodeIfPresent(Double.self, forKey: .shortTermCapitalGains) ?? 0
        shortTermCapitalLosses = try container.decodeIfPresent(Double.self, forKey: .shortTermCapitalLosses) ?? 0
        
        qualifiedDividends = try container.decodeIfPresent(Double.self, forKey: .qualifiedDividends) ?? 0
        nonQualifiedDividends = try container.decodeIfPresent(Double.self, forKey: .nonQualifiedDividends) ?? 0
        
        rentalIncome = try container.decodeIfPresent(Double.self, forKey: .rentalIncome) ?? 0
        royalties = try container.decodeIfPresent(Double.self, forKey: .royalties) ?? 0
        businessIncome = try container.decodeIfPresent(Double.self, forKey: .businessIncome) ?? 0
        foreignEarnedIncome = try container.decodeIfPresent(Double.self, forKey: .foreignEarnedIncome) ?? 0
        
        hsaContribution = try container.decodeIfPresent(Double.self, forKey: .hsaContribution) ?? 0
        iraContribtuion = try container.decodeIfPresent(Double.self, forKey: .iraContribtuion) ?? 0
        iraWithdrawal = try container.decodeIfPresent(Double.self, forKey: .iraWithdrawal) ?? 0
        rothConversion = try container.decodeIfPresent(Double.self, forKey: .rothConversion) ?? 0
        
        marginInterestExpense = try container.decodeIfPresent(Double.self, forKey: .marginInterestExpense) ?? 0
        mortgageInterestExpense = try container.decodeIfPresent(Double.self, forKey: .mortgageInterestExpense) ?? 0
        medicalAndDentalExpense = try container.decodeIfPresent(Double.self, forKey: .medicalAndDentalExpense) ?? 0
        charitableContributions = try container.decodeIfPresent(Double.self, forKey: .charitableContributions) ?? 0
        dafContributions = try container.decodeIfPresent(Double.self, forKey: .dafContributions) ?? 0
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(description, forKey: .description)
        try container.encode(filingStatus, forKey: .filingStatus)
        try container.encode(employmentStatus, forKey: .employmentStatus)

        try container.encode(wagesSelf, forKey: .wagesSelf)
        try container.encode(wagesSpouse, forKey: .wagesSpouse)
        
        try container.encode(socialSecuritySelf, forKey: .socialSecuritySelf)
        try container.encode(socialSecuritySpouse, forKey: .socialSecuritySpouse)
        
        try container.encode(interest, forKey: .interest)
        try container.encode(taxExemptInterest, forKey: .taxExemptInterest)
        
        try container.encode(longTermCapitalGains, forKey: .longTermCapitalGains)
        try container.encode(longTermCapitalLosses, forKey: .longTermCapitalLosses)
        try container.encode(capitalLossCarryOver, forKey: .capitalLossCarryOver)
        
        try container.encode(shortTermCapitalGains, forKey: .shortTermCapitalGains)
        try container.encode(shortTermCapitalLosses, forKey: .shortTermCapitalLosses)
        
        try container.encode(qualifiedDividends, forKey: .qualifiedDividends)
        try container.encode(nonQualifiedDividends, forKey: .nonQualifiedDividends)
        
        try container.encode(hsaContribution, forKey: .hsaContribution)
        try container.encode(iraContribtuion, forKey: .iraContribtuion)
        try container.encode(iraWithdrawal, forKey: .iraWithdrawal)
        try container.encode(rothConversion, forKey: .rothConversion)
        
        try container.encode(rentalIncome, forKey: .rentalIncome)
        try container.encode(royalties, forKey: .royalties)
        try container.encode(businessIncome, forKey: .businessIncome)
        try container.encode(foreignEarnedIncome, forKey: .foreignEarnedIncome)
        
        try container.encode(marginInterestExpense, forKey: .marginInterestExpense)
        try container.encode(mortgageInterestExpense, forKey: .mortgageInterestExpense)
        try container.encode(medicalAndDentalExpense, forKey: .medicalAndDentalExpense)
        try container.encode(charitableContributions, forKey: .charitableContributions)
        try container.encode(dafContributions, forKey: .dafContributions)
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
