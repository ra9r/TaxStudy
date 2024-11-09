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
    var taxScheme: TaxScheme
    
    init(_ scenario: TaxScenario, taxScheme: TaxScheme) {
        self.scenario = scenario
        self.taxScheme = taxScheme
    }
    
    // MARK: - Income
    
    /// **Gross Income** is a complete total of all income generated regarless of any exemptions, adjustements, deductions and credits
    var grossIncome: Double {
        return totalIncome +
        totalTaxExemptIncome
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
    var totalTaxExemptIncome: Double {
        return scenario.taxExemptInterest +
        scenario.qualifiedHSADistributions +
        scenario.rothDistributions +
        scenario.otherTaxExemptIncome
    }
    
    // MARK: - AGI and MAGI
      
    /// **Adjusted Gross Income (AGI)** This is the *Total Income* with adjustments for taxable social security and "above the line" deductions
    var agi: Double {
        return agiBeforeSSI + taxableSSI
    }
    
    var agiBeforeSSI: Double {
        return totalIncome - scenario.totalSocialSecurityIncome - scenario.totalAdjustments
    }
    
    var magiForIRMAA: Double {
        return agi +
        scenario.iraContribtuion +
        scenario.taxExemptInterest +
//        scenario.deductions.total(for: .studentLoanInterestDeduction) +
//        scenario.deductions.total(for: .tuitionAndFeesDeduction) +
//        scenario.adjustments.total(for: .foreignHousingExclusion) +
        scenario.adjustments.total(for: .foreignEarnedIncomeExclusion)
    }
    
    var magiForIRA: Double {
        return agi +
        scenario.iraContribtuion +
        scenario.deductions.total(for: .studentLoanInterestDeduction) +
        scenario.deductions.total(for: .tuitionAndFeesDeduction) +
        scenario.adjustments.total(for: .foreignHousingExclusion) +
        scenario.adjustments.total(for: .foreignEarnedIncomeExclusion)
    }
    
    var magiForRothIRA: Double {
        return magiForIRA
    }
    
    var magiForNIIT: Double {
        return agi +
        scenario.adjustments.total(for: .foreignHousingExclusion) +
        scenario.adjustments.total(for: .foreignEarnedIncomeExclusion)
    }
    
    var magiForACASubsidies: Double {
        return agi +
        scenario.taxExemptInterest +
        scenario.adjustments.total(for: .foreignHousingExclusion) +
        scenario.adjustments.total(for: .foreignEarnedIncomeExclusion)
    }
    
    var magiForPassiveActivityLossRules: Double {
        return agi +
        scenario.taxExemptInterest +
        scenario.adjustments.total(for: .iraOr401kContribution)
    }
    
    var magiForSocialSecurity: Double {
        return agiBeforeSSI +
        scenario.taxExemptInterest +
        scenario.adjustments.total(for: .foreignHousingExclusion) +
        scenario.adjustments.total(for: .foreignEarnedIncomeExclusion)
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
        let capitalLossLimit = taxScheme.capitalLossLimit
        let futureCarryOverLoss = netCapitalGains.futureCarryForwardLoss
        return (futureCarryOverLoss > 0 ? min(capitalLossLimit, futureCarryOverLoss) : 0)
    }
    
    // MARK: - Social Security
    
    var provisionalIncome: Double {
        return magiForSocialSecurity + (scenario.totalSocialSecurityIncome * 0.5)
    }
    
    var provisionalTaxRate: Double {
        do {
            let highestBracket = try taxScheme.provisionalIncomeThresholds.highestBracket(for: provisionalIncome, filingStatus: scenario.filingStatus)
            return highestBracket.rate
        } catch {
            print(error)
            print("Error: No highest bracket for \(provisionalIncome), defaulting to 0.")
            return 0
        }
    }
    
    var taxableSSI: Double {
        if scenario.totalSocialSecurityIncome == 0 { return 0 } // You can't have taxes on SSI if there is no SSI.
        do {
            let highestBracket = try taxScheme.provisionalIncomeThresholds.highestBracket(for: provisionalIncome, filingStatus: scenario.filingStatus)
            let maxTaxableSocialSecurityIncome = scenario.totalSocialSecurityIncome * highestBracket.rate
            let progressiveTax = try taxScheme.provisionalIncomeThresholds.progressiveTax(for: provisionalIncome, filingStatus: scenario.filingStatus)
            
            return min(maxTaxableSocialSecurityIncome, progressiveTax)
        } catch {
            print(error)
            print("Error: No highest bracket for \(provisionalIncome), defaulting to 0.")
            return 0
        }
    }
    
    // MARK: - Deductions
    var standardDeduction: Double {
        guard let standardDeduction = taxScheme.standardDeduction[scenario.filingStatus] else {
            print("Error: No standard deduction for \(scenario.filingStatus), defaulting to 0.")
            return 0
        }
        
        guard let standardDeductionBonus = taxScheme.standardDeductionBonus[scenario.filingStatus] else {
            print("Error: No standard deduction bonus for \(scenario.filingStatus), defaulting to 0.")
            return 0
        }
        
        let selfBonus = scenario.profileSelf.age >= taxScheme.standardDeductionBonusAge ? standardDeductionBonus : 0
        let spouceBonus = scenario.profileSpouse.age >= taxScheme.standardDeductionBonusAge ? standardDeductionBonus : 0
        
        switch scenario.filingStatus {
        case .marriedFilingJointly:
            return standardDeduction + selfBonus + spouceBonus
        default:
            return standardDeduction + selfBonus
        }
    }
    
    var deductibleMedicalExpenses: Double {
        let medicalExpenses = scenario.deductions.total(for: .medicalAndDentalDeduction)
        let threshold = taxScheme.medicalDeductionThreasholdRate * agi
        return max(0, medicalExpenses - threshold)
    }
    
    var deductibleMedicalExpensesForAMT: Double {
        let medicalExpenses = scenario.deductions.total(for: .medicalAndDentalDeduction)
        let threshold = taxScheme.medicalDeductionThreasholdRateForAMT * agi
        return max(0, medicalExpenses - threshold)
    }
    
    var deductibleCharitableCashContributions: Double {
        let charitableContributions = scenario.deductions.total(for: .charitableCashContributionDeduction)
        let threshold = taxScheme.charitableCashThreadholdRate * agi
        return max(0, charitableContributions - threshold)
    }
    
    var deductibleCharitableAssetContributions: Double {
        let charitableContributions = scenario.deductions.total(for: .charitableAssetContributionDeduction)
        let threshold = taxScheme.charitableAssetThreadholdRate * agi
        return max(0, charitableContributions - threshold)
    }
    
    var totalChartitableContributions: Double {
        return deductibleCharitableCashContributions +
        deductibleCharitableAssetContributions +
        scenario.deductions.total(for: .charitableMileageContributionDeduction)
    }
    
    var totalItemizedDeductions: Double {
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
        return max(standardDeduction, totalItemizedDeductions)
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
        if taxableIncome <= 0 {
            return 0
        }
        return taxableIncome - preferentialIncome - capitalLossAdjustment
    }
    
    // MARK: - Computed Taxes
    
    var ordinaryIncomeTax: Double {
        do {
            let progressiveTax = try taxScheme.ordinaryTaxBrackets.progressiveTax(for: ordinaryIncome, filingStatus: scenario.filingStatus)
            return progressiveTax
        } catch {
            print(error)
        }
        return 0
    }
    
    var qualifiedDividendTax: Double {
        do {
            let highestBracket = try taxScheme.capitalGainTaxBrackets.highestBracket(for: preferentialIncome, filingStatus: scenario.filingStatus)
            return scenario.qualifiedDividends * highestBracket.rate
        } catch {
            print(error)
            print("Error: No highest bracket for \(provisionalIncome), defaulting to 0.")
            return 0
        }
        
        
    }
    
    var capitalGainsTax: Double {
        do {
            let highestBracket = try taxScheme.capitalGainTaxBrackets.highestBracket(for: preferentialIncome, filingStatus: scenario.filingStatus)
            return netLTCG * highestBracket.rate
        } catch {
            print(error)
            print("Error: No highest bracket for \(provisionalIncome), defaulting to 0.")
            return 0
        }
        
    }
    
    var netInvestmentIncomeTax: Double {
        guard let threshold = taxScheme.niitThresholds[scenario.filingStatus] else {
            print("Error: Failed to find NIIT threadholds for \(scenario.filingStatus), defaulting to 0")
            return 0
        }
        
        // Check if MAGI exceeds the threshold
        let excessIncome = max(0, magiForNIIT - threshold)
        
        // The 3.8% NIIT is applied to the lesser of net investment income or the excess MAGI
        let niitIncome = min(netInvestmentIncome, excessIncome)
        
        // Calculate the NIIT (3.8% of the applicable income)
        let niit = niitIncome * taxScheme.niitRate
        
        return niit
    }
    
    // MARK: - FICA Taxes
    
    private func totalFICATax(forWages: Double, employmentStatus: EmploymentStatus, ficaThresholds: TaxBrackets) -> Double {
        do {
            let taxOwed = try ficaThresholds.progressiveTax(for: forWages, filingStatus: scenario.filingStatus)
            if employmentStatus == .selfEmployed {
                return (taxOwed * 2)
            }
            
            return taxOwed
        } catch {
            print(error)
            return 0
        }
    }
    
    
    /// Return the portion of FICA taxes for Sociai Security
    var totalFICATaxSocialSecurity: Double {
        let forSelf = totalFICATax(forWages: scenario.wagesSelf, employmentStatus: scenario.profileSelf.employmentStatus, ficaThresholds: taxScheme.ssTaxThresholds)
        
        if scenario.filingStatus == .marriedFilingJointly {
            let forSpouse = totalFICATax(forWages: scenario.wagesSpouse, employmentStatus: scenario.profileSpouse.employmentStatus, ficaThresholds: taxScheme.ssTaxThresholds)
            return forSelf + forSpouse
        } else {
            return forSelf
        }
    }
    
    /// Returns the portion of FICA taxes for Medicare
    var totalFICATaxMedicare: Double {
        let forSelf = totalFICATax(forWages: scenario.wagesSelf, employmentStatus: scenario.profileSelf.employmentStatus, ficaThresholds: taxScheme.medicareTaxThresholds)
        
        if scenario.filingStatus == .marriedFilingJointly {
            let forSpouse = totalFICATax(forWages: scenario.wagesSpouse, employmentStatus: scenario.profileSpouse.employmentStatus, ficaThresholds: taxScheme.medicareTaxThresholds)
            return forSelf + forSpouse
        } else {
            return forSelf
        }
    }
    
    var totalFICATax: Double {
        return totalFICATaxSocialSecurity + totalFICATaxMedicare
    }
    
    var federalTax: Double {
        return ordinaryIncomeTax + qualifiedDividendTax + capitalGainsTax + netInvestmentIncomeTax
    }
    
    var safeHarborTax: Double {
        return federalTax / 4
    }
    
    // MARK: - Tax Rates
    
    var maginalCapitalGainsTaxRate: Double {
        let income = max(0, taxableIncome)
        do {
            let highestBracket = try taxScheme.capitalGainTaxBrackets.highestBracket(for: income, filingStatus: scenario.filingStatus)
            return highestBracket.rate
        } catch {
            print("Error: Failed to find highest bracket for \(income), default to 0")
            return 0
        }
    }
    
    var marginalOrdinaryTaxRate: Double {
        let income = max(0, taxableIncome)
        
        do {
            let highestBracket = try taxScheme.ordinaryTaxBrackets.highestBracket(for: income, filingStatus: scenario.filingStatus)
            return highestBracket.rate
        } catch {
            print("Error: Failed to find highest bracket for \(income), default to 0")
            return 0
        }
    }
    
    var averageTaxRate: Double {
        if grossIncome == 0 {
            return 0
        }
        return federalTax / grossIncome
    }
    
    // MARK: - Computed Flags
    
    var isSubjectToNIIT: Bool {
        guard let threshold = taxScheme.niitThresholds[scenario.filingStatus] else {
            print("Error: Failed to find NIIT threadholds for \(scenario.filingStatus)")
            return false
        }
        return max(0, magiForNIIT - threshold) > 0
    }
    
    var isSubjectToFICA: Bool {
        return scenario.totalWages > 0
    }
    
    // MARK: - IRMAA Surcharges
    
    var irmaaPlanBSurcharge: Double {
        do {
            let bracket = try taxScheme.irmaaPlanBThresholds.highestBracket(for: magiForIRMAA, filingStatus: scenario.filingStatus)
            return bracket.rate
        } catch {
            print("Error: Failed to find IRMAA Plan B surcharge for \(scenario.filingStatus), default to 0")
            return 0
        }
    }
    
    var irmaaPlanDSurcharge: Double {
        do {
            let bracket = try taxScheme.irmaaPlanDThresholds.highestBracket(for: magiForIRMAA, filingStatus: scenario.filingStatus)
            return bracket.rate
        } catch {
            print("Error: Failed to find IRMAA Plan B surcharge for \(scenario.filingStatus), default to 0")
            return 0
        }
    }
       
    // MARK: - Alternative Minimum Tax (AMT)
    var isSubjectToAMT: Bool {
        return amtTax > federalTax
    }
    
    // The starting income for the AMT calculations (AMT version of totalIncome)
    var amtIncome: Double {
        // TODO: what deductions and adjustments disallowed under AMT should be added back?
        let iraOr401kContribution = scenario.adjustments.total(for: .iraOr401kContribution)
        let hsaContribution = scenario.adjustments.total(for: .hsaContribution)
        let earlyWithDrawalPenalties = scenario.adjustments.total(for: .earlyWithDrawalPenalties)
        let businessExpenses = scenario.adjustments.total(for: .businessExpenses)
        let marginInterest = scenario.deductions.total(for: .marginInterestDeduction)
        let mortgageInterest = scenario.deductions.total(for: .mortgageInterestDeduction)
        let medicalExpenses = deductibleMedicalExpensesForAMT
        return totalIncome -
            iraOr401kContribution -
            hsaContribution -
            earlyWithDrawalPenalties -
            businessExpenses -
            marginInterest -
            mortgageInterest -
            medicalExpenses
    }
    
    var amtExemption: Double {
        guard let exemption = taxScheme.amtExemptions[scenario.filingStatus] else {
            print("Error: failed to compute amtReducedExemption, defaulting to 0")
            return 0
        }
        return exemption
    }
    
    var amtPhaseOutTheshold: Double {
        guard let phaseOutTheshold = taxScheme.amtPhaseOutThesholds[scenario.filingStatus] else {
            print("Error: failed to compute amtReducedExemption, defaulting to 0")
            return 0
        }
        return phaseOutTheshold
    }
    
    var amtReducedExemption: Double {
        var reducedExemption: Double = 0
        if (amtIncome > amtPhaseOutTheshold) {
            // compute the reduction of amtExemption, if that amount exceeds amtExemption, return 0
            reducedExemption = max(0, (amtExemption - (amtIncome - amtPhaseOutTheshold) * 0.25))
        } else {
            // if below the threshold then you automatically get the full exemption
            reducedExemption = amtExemption
        }
        return reducedExemption
    }
    
    // The amount of income that is taxable under the AMT rates
    var amtTaxableIncome: Double {
        return amtIncome - amtReducedExemption
    }
    
    var amtTax: Double {
        do {
            return try taxScheme.amtBrackets.progressiveTax(for: amtTaxableIncome, filingStatus: scenario.filingStatus)
        } catch {
            print("Error: failed to compute amt before phase out, defaulting to 0")
            return 0
        }
    }
    
    var amtTaxParts: [ProgressiveTaxPart] {
        do {
            return try taxScheme.amtBrackets.progressiveTaxParts(for: amtTaxableIncome, filingStatus: scenario.filingStatus)
        } catch {
            print("Error: failed to compute amt tax parts, defaulting to 0")
            return []
        }
    }
    
    
    
}
