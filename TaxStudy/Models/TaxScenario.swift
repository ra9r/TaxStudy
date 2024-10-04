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
    var name: String = ""
    
    var socialSecuritySelf: Double = 0
    var socialSecuritySpouse: Double = 0
    
    var interest: Double = 0
    var taxExemptInterest: Double = 0
    
    var longTermCapitalGains: Double = 0
    var longTermCapitalLosses: Double = 0
    var capitalLossCarryOver: Double = 0
    
    var shortTermCapitalGains: Double = 0
    var shortTermCapitalLosses: Double = 0
    
    var qualifiedDividends: Double = 0
    var nonQualifiedDividends: Double = 0
    
    var hsaContribution: Double = 0
    var iraContribtuion: Double = 0
    var iraWithdrawal: Double = 0
    var rothConversion: Double = 0
    
    var marginInterestExpense: Double = 0
    var mortgageInterestExpense: Double = 0
    var medicalAndDentalExpense: Double = 0
    
    var filingStatus: FilingStatus = FilingStatus.marriedFilingJointly
    
    var ordinaryTaxBrackets = TaxBrackets()
    
    var capitalGainTaxBrackets = TaxBrackets()
    
    @Transient
    var federalTaxes: FederalTaxCalc {
        return FederalTaxCalc(self)
    }
    
    @Transient
    var stateTaxes: StateTaxCalc {
        return NCTaxCalc(federalTaxes)
    }
    
    var grossIncome: Double {
        let income = totalSocialSecurityIncome +
        interest +
        taxExemptInterest +
        longTermCapitalGains +
        qualifiedDividends +
        shortTermCapitalGains +
        nonQualifiedDividends +
        rothConversion +
        iraWithdrawal
        return income
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
    
    init(name: String) {
        id = UUID().uuidString
        self.name = name
        socialSecuritySelf = 0
        socialSecuritySpouse = 0
        interest = 0
        taxExemptInterest = 0
        longTermCapitalGains = 0
        longTermCapitalLosses = 0
        capitalLossCarryOver = 0
        shortTermCapitalGains = 0
        shortTermCapitalLosses = 0
        qualifiedDividends = 0
        nonQualifiedDividends = 0
        hsaContribution = 0
        iraContribtuion = 0
        iraWithdrawal = 0
        rothConversion = 0
        marginInterestExpense = 0
        mortgageInterestExpense = 0
        medicalAndDentalExpense = 0
        filingStatus = .marriedFilingJointly
        ordinaryTaxBrackets = TaxBrackets()
        capitalGainTaxBrackets =  TaxBrackets()
    }
        
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case socialSecuritySelf
        case socialSecuritySpouse
        case interest
        case taxExemptInterest
        case longTermCapitalGains
        case longTermCapitalLosses
        case capitalLossCarryOver
        case shortTermCapitalGains
        case shortTermCapitalLosses
        case qualifiedDividends
        case nonQualifiedDividends
        case hsaContribution
        case iraContribtuion
        case iraWithdrawal
        case rothConversion
        case marginInterestExpense
        case mortgageInterestExpense
        case medicalAndDentalExpense
        case filingStatus
        case ordinaryTaxBrackets
        case capitalGainTaxBrackets
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
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
        hsaContribution = try container.decodeIfPresent(Double.self, forKey: .hsaContribution) ?? 0
        iraContribtuion = try container.decodeIfPresent(Double.self, forKey: .iraContribtuion) ?? 0
        iraWithdrawal = try container.decodeIfPresent(Double.self, forKey: .iraWithdrawal) ?? 0
        rothConversion = try container.decodeIfPresent(Double.self, forKey: .rothConversion) ?? 0
        marginInterestExpense = try container.decodeIfPresent(Double.self, forKey: .marginInterestExpense) ?? 0
        mortgageInterestExpense = try container.decodeIfPresent(Double.self, forKey: .mortgageInterestExpense) ?? 0
        medicalAndDentalExpense = try container.decodeIfPresent(Double.self, forKey: .medicalAndDentalExpense) ?? 0
        filingStatus = try container.decodeIfPresent(FilingStatus.self, forKey: .filingStatus) ?? .single
        ordinaryTaxBrackets = try container.decodeIfPresent(TaxBrackets.self, forKey: .ordinaryTaxBrackets) ?? TaxBrackets()
        capitalGainTaxBrackets = try container.decodeIfPresent(TaxBrackets.self, forKey: .ordinaryTaxBrackets)  ?? TaxBrackets()
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(socialSecuritySelf, forKey: .socialSecuritySelf)
        try container.encodeIfPresent(socialSecuritySpouse, forKey: .socialSecuritySpouse)
        try container.encodeIfPresent(interest, forKey: .interest)
        try container.encodeIfPresent(taxExemptInterest, forKey: .taxExemptInterest)
        try container.encodeIfPresent(longTermCapitalGains, forKey: .longTermCapitalGains)
        try container.encodeIfPresent(longTermCapitalLosses, forKey: .longTermCapitalLosses)
        try container.encodeIfPresent(capitalLossCarryOver, forKey: .capitalLossCarryOver)
        try container.encodeIfPresent(shortTermCapitalGains, forKey: .shortTermCapitalGains)
        try container.encodeIfPresent(shortTermCapitalLosses, forKey: .shortTermCapitalLosses)
        try container.encodeIfPresent(qualifiedDividends, forKey: .qualifiedDividends)
        try container.encodeIfPresent(nonQualifiedDividends, forKey: .nonQualifiedDividends)
        try container.encodeIfPresent(hsaContribution, forKey: .hsaContribution)
        try container.encodeIfPresent(iraContribtuion, forKey: .iraContribtuion)
        try container.encodeIfPresent(iraWithdrawal, forKey: .iraWithdrawal)
        try container.encodeIfPresent(rothConversion, forKey: .rothConversion)
        try container.encodeIfPresent(marginInterestExpense, forKey: .marginInterestExpense)
        try container.encodeIfPresent(mortgageInterestExpense, forKey: .mortgageInterestExpense)
        try container.encodeIfPresent(medicalAndDentalExpense, forKey: .medicalAndDentalExpense)
        try container.encodeIfPresent(filingStatus, forKey: .filingStatus)
        try container.encodeIfPresent(ordinaryTaxBrackets, forKey: .ordinaryTaxBrackets)
        try container.encodeIfPresent(capitalGainTaxBrackets, forKey: .capitalGainTaxBrackets)
    }
}

extension TaxScenario : Hashable {
    // Conforming to Hashable
        static func == (lhs: TaxScenario, rhs: TaxScenario) -> Bool {
            return lhs.id == rhs.id
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
}
