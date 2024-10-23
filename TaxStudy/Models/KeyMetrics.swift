//
//  KeyMetrics.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/22/24.
//

import Foundation

enum KeyMetricTypes: Codable {
    // MARK: - Profile
    case selfName
    case spouseName
    case selfAge
    case spouseAge
    case selfWages
    case spouseWages
    case selfSSI
    case spouseSSI
    case selfMedical
    case spouseMedical
    case selfEmployement
    case spouseEmployement
    case filingStatus
    
    // MARK: - Income Totals
    case taxRules
    case grossIncome
    case totalIncome
    case totalTaxExemptInterestIncome
    case totalExcludedIncome
    case totalWages
    case totalSSI
    case totalIncomeOfType(IncomeType)
    case totalDeductionOftype(TaxDeductionType)
    case totalAdjustmentOfType(TaxAdjustmentType)
    case totalCreditsOfType(TaxCreditType)
        
    
    // MARK: - AGI and MAGI's
    case agi
    case agiBeforeSSI
    case magiForIRMAA
    case magiForIRA
    case magiForRothIRA
    case magiForNIIT
    case magiForACASubsidies
    case magiForPassiveActivityLossRules
    case magiForSocialSecurity
    
    // MARK: - Investment Income
    case interest
    case taxExemptInterest
    case carryforwarLoss
    case dividends
    case totalDividends
    case totalRentalIncome
    case totalRoyalties
    case totalBusinessIncome
    case totalForeignEarnedIncome
    case totalRetirementContributions
    
    // MARK: - Investment Computed
    case netLTCG
    case netSTCG
    case futureCarryForwardLoss
    case netInvestmentIncome
    case capitalLossAdjustment
    
    // MARK: - Social Security
    case provisionalIncome
    case provisionalTaxRate
    case taxableSSAIncome
    
    // MARK: - Deductions
    case standardDeduction
    case deductibleMedicalExpenses
    case deductibleCharitableCashContributions
    case deductibleCharitableAssetContributions
    case totalDecutibleChartitableContributions
    case totalItemizedDeductions
    case deduction
    case deductionMethod
    
    // MARK: - Final Calculations
    case taxableIncome
    case preferentialIncome
    case ordinaryIncome
    
    // MARK: - Computed Taxes
    case ordinaryIncomeTax
    case qualifiedDividendTax
    case capitalGainsTax
    case netInvestmentIncomeTax
    case federalTax
    case safeHarborTax
    
    // MARK: - FICA Taxes
    case totalFICATax
    case totalFICATaxSocialSecurity
    case totalFICATaxMedicare
    
    // MARK: - Tax Rates
    case maginalCapitalGainsTaxRate
    case marginalOrdinaryTaxRate
    case averageTaxRate
    case effectiveTaxRate
    
    // MARK: - Misc Computed Flags
    case isSubjectToNIIT
    case isSubjectToFICA
    
    // MARK: - IRMAA Surcharges
    case isSubjectToIRMAA
    case irmaaPlanDSurcharge
    case irmaaPlanBSurcharge
    
    // MARK: - Alternative Minimum Tax (AMT)
    case isSubjectToAMT
    case amtIncome
    case amtExemption
    case amtPhaseOutTheshold
    case amtReducedExemption
    case amtTaxableIncome
    case amtTax
}
