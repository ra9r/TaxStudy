//
//  FederalTaxCalc.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/1/24.
//

class FederalTaxCalc {
    
    var taxScenario: TaxScenario
    
    init(_ taxScenario: TaxScenario) {
        self.taxScenario = taxScenario
    }
    
    var totalDividends: Double {
        return taxScenario.qualifiedDividends + taxScenario.nonQualifiedDividends
    }
    
    var netSTCG: Double {
        return taxScenario.shortTermCapitalGains - taxScenario.shortTermCapitalLosses
    }
    
    var netLTCG: Double {
        return taxScenario.longTermCapitalGains - taxScenario.longTermCapitalLosses - taxScenario.capitalLossCarryOver - (netSTCG < 0 ? 0 : abs(netSTCG))
    }
    
    var netInvestmentIncome: Double {
        return max(0, netLTCG) + max(0, netSTCG) + totalDividends + taxScenario.interest + taxScenario.rentalIncome + taxScenario.royalties + taxScenario.businessIncome
    }
    
    var capitalLossDeduction: Double {
        let capitalLossDecutionLimit: Double = 3000
        return netLTCG > 0 ? 0 : min(capitalLossDecutionLimit, abs(netLTCG))
    }
    
    var futureCarryOverLoss: Double {
        return netLTCG < 0 ? abs(netLTCG) - capitalLossDeduction : 0
    }
    
    var agiBeforeSSDI: Double {
        return taxScenario.grossIncome - taxScenario.totalSocialSecurityIncome - taxScenario.hsaContribution - taxScenario.taxExemptInterest - capitalLossDeduction
    }
    
    var agi: Double {
        return agiBeforeSSDI + taxableSSDI
    }
    
    var magi: Double {
        // For simplicity, assume MAGI = AGI
        return agi
    }
    
    var provisionalIncome: Double {
        return agiBeforeSSDI + taxScenario.taxExemptInterest + (taxScenario.totalSocialSecurityIncome * 0.5)
    }
    
    var provisionalTaxRate: Double {
        guard let provisionalTaxRates = taxScenario.facts.provisionalIncomeThresholds[taxScenario.filingStatus] else {
            print("Error: No provisional tax rates for \(provisionalIncome), defaulting to 0.")
            return 0
        }
        return provisionalTaxRates.highestRate(for: provisionalIncome)
    }
    
    var taxableSSDI: Double {
        return taxScenario.totalSocialSecurityIncome * provisionalTaxRate
    }
    
    var standardDeduction: Double {
        guard let standardDeduction = taxScenario.facts.standardDeduction[taxScenario.filingStatus] else {
            print("Error: No standard deduction for \(taxScenario.filingStatus), defaulting to 0.")
            return 0
        }
        return standardDeduction
    }
    
    var deductibleMedicalExpenses: Double {
        let medicalExpenses = taxScenario.medicalAndDentalExpense
        let threshold = 0.075 * agi
        return max(0, medicalExpenses - threshold)
    }
    
    var itemizedDeductions: Double {
        let mortgageInterest = taxScenario.mortgageInterestExpense
        let marginInterest = taxScenario.marginInterestExpense
        let medicalExpenses = deductibleMedicalExpenses
        return mortgageInterest + marginInterest + medicalExpenses
    }
    
    var deduction: Double {
        return max(standardDeduction, itemizedDeductions)
    }
    
    var deductionMethod: String {
        if deduction == standardDeduction {
            return "Standard"
        }
        return "Itemized"
    }
    
    var taxableIncome: Double {
        return max(0, agi - deduction)
    }
    
    var ordinaryIncome: Double {
        return taxableIncome - taxScenario.qualifiedDividends - max(0, netLTCG)
    }
    
    var ordinaryIncomeTax: Double {
        guard let ordinaryTaxBrackets = taxScenario.facts.ordinaryTaxBrackets[taxScenario.filingStatus] else {
            print("Failed to find tax brackets for \(taxScenario.filingStatus)")
            return 0
        }
        return ordinaryTaxBrackets.progressiveTax(for: ordinaryIncome)
    }
    
    var qualifiedDividendTax: Double {
        guard let capitalGainTaxBrackets = taxScenario.facts.capitalGainTaxBrackets[taxScenario.filingStatus] else {
            print("Failed to find tax brackets for \(taxScenario.filingStatus)")
            return 0
        }
        return taxScenario.qualifiedDividends * capitalGainTaxBrackets.highestRate(for: taxableIncome)
    }
    
    var capitalGainsTax: Double {
        guard let capitalGainTaxBrackets = taxScenario.facts.capitalGainTaxBrackets[taxScenario.filingStatus] else {
            print("Failed to find tax brackets for \(taxScenario.filingStatus)")
            return 0
        }
        return max(0, netLTCG) * capitalGainTaxBrackets.highestRate(for: taxableIncome)
    }
    
    var taxesOwed: Double {
        return ordinaryIncomeTax + qualifiedDividendTax + capitalGainsTax + netInvestmentIncomeTax + socialSecurityTaxesOwed + medicareTaxesOwed
    }
    
    var effectiveTaxRate: Double {
        if taxScenario.grossIncome == 0 {
            return 0
        }
        return taxesOwed / taxScenario.grossIncome
    }
    
    var netInvestmentIncomeTax: Double {
        guard let threshold = taxScenario.facts.niitThresholds[taxScenario.filingStatus] else {
            print("Error: Failed to find NIIT threadholds for \(taxScenario.filingStatus), defaulting to 0")
            return 0
        }
        
        // Check if MAGI exceeds the threshold
        let excessIncome = max(0, magi - threshold)
        
        // The 3.8% NIIT is applied to the lesser of net investment income or the excess MAGI
        let niitIncome = min(netInvestmentIncome, excessIncome)
        
        // Calculate the NIIT (3.8% of the applicable income)
        let niit = niitIncome * taxScenario.facts.niitRate
        
        return niit
    }
    
    var isSubjectToNIIT: Bool {
        guard let threshold = taxScenario.facts.niitThresholds[taxScenario.filingStatus] else {
            print("Error: Failed to find NIIT threadholds for \(taxScenario.filingStatus)")
            return false
        }
        return max(0, magi - threshold) > 0
    }
    
    var isSubjectToFICA: Bool {
        return taxScenario.totalWages > 0
    }
    
    var socialSecurityTaxesOwed: Double {
        guard let taxRates = taxScenario.facts.ssTaxThresholds[taxScenario.filingStatus] else {
            print("Error: Failed to find SS tax rates for \(taxScenario.filingStatus)")
            return 0
        }
        let forSelf = taxRates.progressiveTax(for: taxScenario.wagesSelf)
        let forSpouse = taxRates.progressiveTax(for: taxScenario.wagesSpouse)
        
        if taxScenario.employmentStatus == .selfEmployed {
            return (forSelf * 2) + (forSpouse * 2)
        }
        
        return forSelf + forSpouse
    }
    
    var medicareTaxesOwed: Double {
        guard let taxRates = taxScenario.facts.medicareTaxThresholds[taxScenario.filingStatus] else {
            print("Error: Failed to find Medicate tax rates for \(taxScenario.filingStatus)")
            return 0
        }
        let forSelf = taxRates.progressiveTax(for: taxScenario.wagesSelf)
        let forSpouse = taxRates.progressiveTax(for: taxScenario.wagesSpouse)
        
        if taxScenario.employmentStatus == .selfEmployed {
            return (forSelf * 2) + (forSpouse * 2)
        }
        
        return forSelf + forSpouse
    }
    
    
}
