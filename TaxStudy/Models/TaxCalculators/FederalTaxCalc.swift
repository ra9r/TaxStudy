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
    
    // MARK: - Income
    
    /// **Gross Income** is a complete total of all income generated regarless of any exemptions, adjustements, deductions and credits
    var grossIncome: Double {
        return totalIncome +
        taxExemptIncome
    }
    
    /// **Total Income** is *gross income* minus all tax-exempt income
    var totalIncome: Double {
        let income = scenario.totalWages +
        scenario.totalSocialSecurityIncome +
        scenario.interest +
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
    
    /// **Tax Exempt Income** is all income that is not factored into *Total Income*.  This income has absolutely no impact on your
    /// federal taxes.
    var taxExemptIncome: Double {
        return scenario.taxExemptInterest +
        scenario.qualifiedHSADistributions +
        scenario.rothDistributions +
        scenario.otherTaxExemptIncome
    }
    
    /// **AGI Before Social Security** This is a computed value that is used to compute various social security values.
    var agiBeforeSSDI: Double {
        return totalIncome - scenario.totalSocialSecurityIncome - scenario.totalAdjustments
    }
    
    /// **Adjusted Gross Income (AGI)** This is the *Total Income* with adjustments for taxable social security and "above the line" deductions
    var agi: Double {
        return agiBeforeSSDI + taxableSSDI
    }
    
    var magi: Double {
        // For simplicity, assume MAGI = AGI
        return agi
    }
    
    // MARK: - Investment
    
    /// Internal method that computes the capital gains for other computations
    private var netCapitalGains: NetCapitalGains {
        
        let totalCapitalLosses = scenario.carryforwardLoss
        
        let netLTCG = scenario.longTermCapitalGains - totalCapitalLosses
        
        let netSTCG = scenario.shortTermCapitalGains - (netLTCG < 0 ? abs(netLTCG) : 0)
        
        let futureCarrryOver = netSTCG < 0 ? abs(netSTCG) : 0
        
        return .init(
            netLTCG: max(0, netLTCG),
            netSTCG: max(0, netSTCG),
            futureCarryForwardLoss: futureCarrryOver)
        
    }
    
    /// The net short-term capital  gains.  This value is never negative, only greater or equal to zero.
    var netSTCG: Double {
        return netCapitalGains.netSTCG
    }
    
    /// The net long-term capital  gains.  This value is never negative, only greater or equal to zero.
    var netLTCG: Double {
        return netCapitalGains.netLTCG
    }
    
    /// The resulting carryforward loss after *netLTCG* and *netSTCG* are computed
    var futureCarryForwardLoss: Double {
        return netCapitalGains.futureCarryForwardLoss - capitalLossAdjustment
    }
    
    /// **Net Investment Income (NII)** refers to income derived from investments, after deducting any
    /// allowable expenses related to those investments. It includes income such as interest, dividends,
    /// capital gains, rental income, and other types of passive income.
    var netInvestmentIncome: Double {
        let marginInterest = scenario.deductions.total(for: .marginInterestDeduction)
        let rentalPropertyExpense = scenario.deductions.total(for: .rentalPropertyExpensesDeduction)
        
        let result = netLTCG + netSTCG + scenario.totalDividends + scenario.interest + scenario.rentalIncome +
        scenario.royalties - marginInterest - rentalPropertyExpense
        
        return result
    }
    
    /// Computes how must of the remaining capital losses can be deducted from ordinary income up to a max of $3000
    /// which is a limit defined by the ``TaxFacts``
    var capitalLossAdjustment: Double {
        let capitalLossLimit = facts.capitalLossLimit
        let futureCarryOverLoss = netCapitalGains.futureCarryForwardLoss
        return (futureCarryOverLoss > 0 ? min(capitalLossLimit, futureCarryOverLoss) : 0)
    }
    
    // MARK: - Social Security
    
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
    
    // MARK: - Deductions
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
    
    var deductibleCharitableCashContributions: Double {
        let charitableContributions = scenario.deductions.total(for: .charitableCashContributionDeduction)
        let threshold = facts.charitableCashThreadholdRate * agi
        return max(0, charitableContributions - threshold)
    }
    
    var deductibleCharitableAssetContributions: Double {
        let charitableContributions = scenario.deductions.total(for: .charitableAssetContributionDeduction)
        let threshold = facts.charitableAssetThreadholdRate * agi
        return max(0, charitableContributions - threshold)
    }
    
    var totalChartitableContributions: Double {
        return deductibleCharitableCashContributions +
        deductibleCharitableAssetContributions +
        scenario.deductions.total(for: .charitableMileageContributionDeduction)
    }
    
    var itemizedDeductions: Double {
        let mortgageInterest = scenario.deductions.total(for: .mortgageInterestDeduction)
        let marginInterest = scenario.deductions.total(for: .marginInterestDeduction)
        let rentalExpenses = scenario.deductions.total(for: .rentalPropertyExpensesDeduction)
        let medicalExpenses = deductibleMedicalExpenses
        let stateAndLocalTax = scenario.deductions.total(for: .stateAndLocalTaxDeduction)
        let tuitionAndFees = scenario.deductions.total(for: .tuitionAndFeesDeduction)
        let customDeductions = scenario.deductions.total(for: .customDeduction)

        return mortgageInterest + marginInterest + rentalExpenses + medicalExpenses + stateAndLocalTax +
        tuitionAndFees + customDeductions + totalChartitableContributions
    }
    
    var deduction: Double {
        return max(standardDeduction, itemizedDeductions)
    }
    
    var deductionMethod: String {
        if deduction == standardDeduction {
            return String(localized: "Standard")
        }
        return String(localized: "Itemized")
    }
    
    // MARK: - Final Calculations
    
    var taxableIncome: Double {
        return max(0, agi - deduction)
    }
    
    var preferentialIncome: Double {
        return scenario.qualifiedDividends + netLTCG
    }
    
    var ordinaryIncome: Double {
        return taxableIncome - preferentialIncome - capitalLossAdjustment
    }
    
    // MARK: - Computed Taxes
    
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
    
    var socialSecurityTax: Double {
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
    
    var medicareTax: Double {
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
        return socialSecurityTax + medicareTax
    }

    var taxesOwed: Double {
        return ordinaryIncomeTax + qualifiedDividendTax + capitalGainsTax + netInvestmentIncomeTax + totalFICATax
    }
    
    var safeHarborTax: Double {
        return taxesOwed / 4
    }
    
    // MARK: - Tax Rates
    
    var maginalCapitalGainsTaxRate: Double {
        let brackets = facts.capitalGainTaxBrackets[scenario.filingStatus]
        
        return brackets?.highestRate(for: preferentialIncome) ?? 0
    }
    
    var marginalOrdinaryTaxRate: Double {
        let brackets = facts.ordinaryTaxBrackets[scenario.filingStatus]
        
        return brackets?.highestRate(for: ordinaryIncome) ?? 0
    }
    
    var averageTaxRate: Double {
        if grossIncome == 0 {
            return 0
        }
        return taxesOwed / grossIncome
    }
    
    // MARK: - Computed Flags
    
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

}
