//
//  FederalTaxCalc.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/1/24.
//

struct NetCapitalGains: Codable {
    let netLTCG: Double
    let netSTCG: Double
    let futureCarrryOver: Double
}

class FederalTaxCalc {
    
    var taxScenario: TaxScenario
    
    init(_ taxScenario: TaxScenario) {
        self.taxScenario = taxScenario
    }
    
    var totalDividends: Double {
        return taxScenario.qualifiedDividends + taxScenario.nonQualifiedDividends
    }
    
    var netCapitalGains: NetCapitalGains {
        
        let totalCapitalLosses = taxScenario.shortTermCapitalLosses + taxScenario.longTermCapitalLosses + taxScenario.capitalLossCarryOver
        
        let netLTCG = taxScenario.longTermCapitalGains - totalCapitalLosses
        
        let netSTCG = taxScenario.shortTermCapitalGains - (netLTCG < 0 ? abs(netLTCG) : 0)
        
        let futureCarrryOver = netSTCG < 0 ? abs(netSTCG) : 0
        
        return .init(
            netLTCG: max(0, netLTCG),
            netSTCG: max(0, netSTCG),
            futureCarrryOver: futureCarrryOver)
        
    }
    
    var netSTCG: Double {
        return netCapitalGains.netSTCG
    }
    
    var netLTCG: Double {
        return netCapitalGains.netLTCG
    }
    
    var netInvestmentIncome: Double {
        return netLTCG + netSTCG + totalDividends + taxScenario.interest + taxScenario.rentalIncome + taxScenario.royalties + taxScenario.businessIncome
    }
    
    var futureCarryOverLoss: Double {
        return netCapitalGains.futureCarrryOver - capitalLossAdjustment
    }
    
    var capitalLossAdjustment: Double {
        let capitalLossLimit = taxScenario.facts.capitalLossLimit
        let futureCarryOverLoss = netCapitalGains.futureCarrryOver
        return (futureCarryOverLoss > 0 ? min(capitalLossLimit, futureCarryOverLoss) : 0)
    }
    
    var grossIncome: Double {
        let income = taxScenario.totalWages +
        taxScenario.totalSocialSecurityIncome +
        taxScenario.interest +
        taxScenario.taxExemptInterest +
        netLTCG +
        taxScenario.qualifiedDividends +
        netSTCG +
        taxScenario.nonQualifiedDividends +
        taxScenario.rentalIncome +
        taxScenario.royalties +
        taxScenario.businessIncome +
        taxScenario.foreignEarnedIncome +
        taxScenario.rothConversion +
        taxScenario.iraWithdrawal
        return income
    }
    
    var agiBeforeSSDI: Double {
        return taxScenario.grossIncome - taxScenario.totalSocialSecurityIncome - taxScenario.hsaContribution - taxScenario.taxExemptInterest
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
    
    var preferentialIncome: Double {
        return taxScenario.qualifiedDividends + netLTCG
    }
    
    var ordinaryIncome: Double {
        return taxableIncome - preferentialIncome - capitalLossAdjustment
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
        return ordinaryIncomeTax + qualifiedDividendTax + capitalGainsTax + netInvestmentIncomeTax + totalFICATax
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
    
    var totalFICATax: Double {
        return socialSecurityTaxesOwed + medicareTaxesOwed
    }
    
    
}
