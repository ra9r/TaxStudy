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
    
    var taxableSSDI: Double {
        let provisionalIncome = agiBeforeSSDI + taxScenario.taxExemptInterest + (taxScenario.totalSocialSecurityIncome * 0.5)
        return taxScenario.totalSocialSecurityIncome * (provisionalIncome > 34000 ? 0.85 : 0.5)
    }
    
    var standardDeduction: Double {
        return 14600 // 2023 standard deduction for single filers
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
    
    var taxableIncome: Double {
        return max(0, agi - deduction)
    }
    
    var ordinaryIncome: Double {
        return taxableIncome - taxScenario.qualifiedDividends - max(0, netLTCG)
    }
    
    var ordinaryIncomeTax: Double {
        return taxScenario.ordinaryTaxBrackets.progressiveTax(for: ordinaryIncome, filingAs: taxScenario.filingStatus)
    }
    
    var qualifiedDividendTax: Double {
        return taxScenario.qualifiedDividends * taxScenario.capitalGainTaxBrackets.highestRate(for: taxableIncome, filingAs: taxScenario.filingStatus)
    }
    
    var capitalGainsTax: Double {
        return max(0, netLTCG) * taxScenario.capitalGainTaxBrackets.highestRate(for: taxableIncome, filingAs: taxScenario.filingStatus)
    }
    
    var taxesOwed: Double {
        return ordinaryIncomeTax + qualifiedDividendTax + capitalGainsTax
    }
    
    var effectiveTaxRate: Double {
        if taxScenario.grossIncome == 0 {
            return 0
        }
        return taxesOwed / taxScenario.grossIncome
    }
}
