//
//  FederalTaxCalc.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/1/24.
//

struct NetCapitalGains: Codable {
    let netLTCG: Double
    let netSTCG: Double
    let futureCarryForwardLoss: Double
}

class FederalTaxCalc {
    
    var scenario: TaxScenario
    var facts: TaxFacts
    
    init(_ scenario: TaxScenario, facts: TaxFacts? = nil) {
        self.scenario = scenario
        self.facts = facts ?? DefaultTaxFacts2024
    }
    
    // MARK: - Computed Values
    var grossIncome: Double {
        return totalIncome + scenario.taxExemptIncome
    }
    
    
    
    var netCapitalGains: NetCapitalGains {
        
        let totalCapitalLosses = scenario.carryforwardLoss
        
        let netLTCG = scenario.longTermCapitalGains - totalCapitalLosses
        
        let netSTCG = scenario.shortTermCapitalGains - (netLTCG < 0 ? abs(netLTCG) : 0)
        
        let futureCarrryOver = netSTCG < 0 ? abs(netSTCG) : 0
        
        return .init(
            netLTCG: max(0, netLTCG),
            netSTCG: max(0, netSTCG),
            futureCarryForwardLoss: futureCarrryOver)
        
    }
    
    var netSTCG: Double {
        return netCapitalGains.netSTCG
    }
    
    var netLTCG: Double {
        return netCapitalGains.netLTCG
    }
    
    var netInvestmentIncome: Double {
        return netLTCG + netSTCG + scenario.totalDividends + scenario.interest + scenario.rentalIncome + scenario.royalties + scenario.businessIncome
    }
    
    var futureCarryForwardLoss: Double {
        return netCapitalGains.futureCarryForwardLoss - capitalLossAdjustment
    }
    
    var capitalLossAdjustment: Double {
        let capitalLossLimit = facts.capitalLossLimit
        let futureCarryOverLoss = netCapitalGains.futureCarryForwardLoss
        return (futureCarryOverLoss > 0 ? min(capitalLossLimit, futureCarryOverLoss) : 0)
    }
    
    var totalIncome: Double {
        let income = scenario.totalWages +
        scenario.totalSocialSecurityIncome +
        scenario.interest +
//        taxScenario.taxExemptInterest + // excluded from Gross Income calculations
        netLTCG +
        scenario.qualifiedDividends +
        netSTCG +
        scenario.ordinaryDividends +
        scenario.rentalIncome +
        scenario.royalties +
        scenario.businessIncome +
        scenario.foreignEarnedIncome +
        scenario.rothConversion +
        scenario.iraWithdrawal
        return income
    }
    
    var agiBeforeSSDI: Double {
        return totalIncome - scenario.totalSocialSecurityIncome - scenario.hsaContribution
    }
    
    var agi: Double {
        return agiBeforeSSDI + taxableSSDI
    }
    
    var magi: Double {
        // For simplicity, assume MAGI = AGI
        return agi
    }
    
    var provisionalIncome: Double {
        return agiBeforeSSDI + scenario.taxExemptInterest + (scenario.totalSocialSecurityIncome * 0.5)
    }
    
    var provisionalTaxRate: Double {
        guard let provisionalTaxRates = facts.provisionalIncomeThresholds[scenario.filingStatus] else {
            print("Error: No provisional tax rates for \(provisionalIncome), defaulting to 0.")
            return 0
        }
        return provisionalTaxRates.highestRate(for: provisionalIncome)
    }
    
    var taxableSSDI: Double {
        return scenario.totalSocialSecurityIncome * provisionalTaxRate
    }
    
    var standardDeduction: Double {
        guard let standardDeduction = facts.standardDeduction[scenario.filingStatus] else {
            print("Error: No standard deduction for \(scenario.filingStatus), defaulting to 0.")
            return 0
        }
        return standardDeduction
    }
    
    var deductibleMedicalExpenses: Double {
        let medicalExpenses = scenario.deductions.total(for: .medicalAndDentalDeduction)
        let threshold = 0.075 * agi
        return max(0, medicalExpenses - threshold)
    }
    
    var itemizedDeductions: Double {
        let mortgageInterest = scenario.deductions.total(for: .mortgageInterestDeduction)
        let marginInterest = scenario.deductions.total(for: .marginInterestDeduction)
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
        return scenario.qualifiedDividends + netLTCG
    }
    
    var ordinaryIncome: Double {
        return taxableIncome - preferentialIncome - capitalLossAdjustment
    }
    
    var ordinaryIncomeTax: Double {
        guard let ordinaryTaxBrackets = facts.ordinaryTaxBrackets[scenario.filingStatus] else {
            print("Failed to find tax brackets for \(scenario.filingStatus)")
            return 0
        }
        return ordinaryTaxBrackets.progressiveTax(for: ordinaryIncome)
    }
    
    var qualifiedDividendTax: Double {
        guard let capitalGainTaxBrackets = facts.capitalGainTaxBrackets[scenario.filingStatus] else {
            print("Failed to find tax brackets for \(scenario.filingStatus)")
            return 0
        }
        return scenario.qualifiedDividends * capitalGainTaxBrackets.highestRate(for: taxableIncome)
    }
    
    var capitalGainsTax: Double {
        guard let capitalGainTaxBrackets = facts.capitalGainTaxBrackets[scenario.filingStatus] else {
            print("Failed to find tax brackets for \(scenario.filingStatus)")
            return 0
        }
        return max(0, netLTCG) * capitalGainTaxBrackets.highestRate(for: taxableIncome)
    }
    
    var taxesOwed: Double {
        return ordinaryIncomeTax + qualifiedDividendTax + capitalGainsTax + netInvestmentIncomeTax + totalFICATax
    }
    
    var effectiveTaxRate: Double {
        if grossIncome == 0 {
            return 0
        }
        return taxesOwed / grossIncome
    }
    
    var netInvestmentIncomeTax: Double {
        guard let threshold = facts.niitThresholds[scenario.filingStatus] else {
            print("Error: Failed to find NIIT threadholds for \(scenario.filingStatus), defaulting to 0")
            return 0
        }
        
        // Check if MAGI exceeds the threshold
        let excessIncome = max(0, magi - threshold)
        
        // The 3.8% NIIT is applied to the lesser of net investment income or the excess MAGI
        let niitIncome = min(netInvestmentIncome, excessIncome)
        
        // Calculate the NIIT (3.8% of the applicable income)
        let niit = niitIncome * facts.niitRate
        
        return niit
    }
    
    var isSubjectToNIIT: Bool {
        guard let threshold = facts.niitThresholds[scenario.filingStatus] else {
            print("Error: Failed to find NIIT threadholds for \(scenario.filingStatus)")
            return false
        }
        return max(0, magi - threshold) > 0
    }
    
    var isSubjectToFICA: Bool {
        return scenario.totalWages > 0
    }
    
    var socialSecurityTaxesOwed: Double {
        guard let taxRates = facts.ssTaxThresholds[scenario.filingStatus] else {
            print("Error: Failed to find SS tax rates for \(scenario.filingStatus)")
            return 0
        }
        let forSelf = taxRates.progressiveTax(for: scenario.wagesSelf)
        let forSpouse = taxRates.progressiveTax(for: scenario.wagesSpouse)
        
        if scenario.employmentStatus == .selfEmployed {
            return (forSelf * 2) + (forSpouse * 2)
        }
        
        return forSelf + forSpouse
    }
    
    var medicareTaxesOwed: Double {
        guard let taxRates = facts.medicareTaxThresholds[scenario.filingStatus] else {
            print("Error: Failed to find Medicate tax rates for \(scenario.filingStatus)")
            return 0
        }
        let forSelf = taxRates.progressiveTax(for: scenario.wagesSelf)
        let forSpouse = taxRates.progressiveTax(for: scenario.wagesSpouse)
        
        if scenario.employmentStatus == .selfEmployed {
            return (forSelf * 2) + (forSpouse * 2)
        }
        
        return forSelf + forSpouse
    }
    
    var totalFICATax: Double {
        return socialSecurityTaxesOwed + medicareTaxesOwed
    }
    
    
}
