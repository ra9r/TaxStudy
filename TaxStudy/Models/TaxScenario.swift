//
//  TaxScenario.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 9/27/24.
//

import Foundation

@Observable
class TaxScenario: Codable, Identifiable {
    
    var id: UUID = UUID()
    
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
    
    var filingStatus: FilingStatus = .marriedFilingJointly
    
    var ordinaryTaxBrackets = TaxBrackets()
    
    var capitalGainTaxBrackets = TaxBrackets()
    
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
    
    var federalTaxes: FederalTaxCalc {
        return FederalTaxCalc(self)
    }
    
    var stateTaxes: StateTaxCalc {
        return NCTaxCalc(federalTaxes)
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
}
