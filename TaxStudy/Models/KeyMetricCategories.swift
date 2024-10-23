//
//  KeyMetricCategories.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/23/24.
//


enum KeyMetricCategories: String, CaseIterable {
    case profile
    case income
    case agiAndMagis
    case investments
    case socialSecurity
    case deductions
    case taxes
    case wages
    case irmaa
    case amt
    case taxRates
    case computedFlags
    
    var types: [KeyMetricTypes] {
        switch self {
        case .profile: return [
            .selfName,
            .spouseName,
            .selfAge,
            .spouseAge,
            .selfWages,
            .spouseWages,
            .selfSSI,
            .spouseSSI,
            .selfMedical,
            .spouseMedical,
            .selfEmployement,
            .spouseEmployement,
            .filingStatus,
            ]
        case .income: return [
            .taxRules,
            .grossIncome,
            .totalIncome,
            .taxableIncome,
            .totalTaxExemptInterestIncome,
            .totalAdjustments,
            .totalWages,
            .totalSSAIncome,
            .preferentialIncome,
            .ordinaryIncome,
            .netInvestmentIncome,
            .provisionalIncome,
            ]
        case .agiAndMagis: return [
            .agi,
            .agiBeforeSSI,
            .magiForIRMAA,
            .magiForIRA,
            .magiForRothIRA,
            .magiForNIIT,
            .magiForACASubsidies,
            .magiForPassiveActivityLossRules,
            .magiForSocialSecurity,
            ]
        case .investments: return [
            .interest,
            .carryforwardLoss,
            .dividends,
            .capitalGains,
            .totalDividends,
            .netLTCG,
            .netSTCG,
            .futureCarryForwardLoss,
            .netInvestmentIncome,
            .capitalLossAdjustment,
            ]
        case .socialSecurity: return [
            .totalSSAIncome,
            .provisionalIncome,
            .provisionalTaxRate,
            .taxableSSAIncome,
            ]
        case .deductions: return [
            .standardDeduction,
            .deductibleMedicalExpenses,
            .deductibleCharitableCashContributions,
            .deductibleCharitableAssetContributions,
            .totalDecutibleChartitableContributions,
            .totalItemizedDeductions,
            .deduction,
            .deductionMethod,
            ]
        case .taxes: return [
            .ordinaryIncomeTax,
            .qualifiedDividendTax,
            .capitalGainsTax,
            .netInvestmentIncomeTax,
            .amtTax,
            .federalTax,
            .safeHarborTax,
            .totalFICATax,
            .totalFICATaxSocialSecurity,
            .totalFICATaxMedicare,
            ]
        case .wages: return [
            .selfWages,
            .spouseWages,
            .totalWages,
            .totalFICATax,
            .totalFICATaxSocialSecurity,
            .totalFICATaxMedicare,
            ]
        case .irmaa: return [
            .isSubjectToIRMAA,
            .irmaaPlanDSurcharge,
            .irmaaPlanBSurcharge,
            .irmaaSurcharges,
            ]
        case .amt: return [
            .isSubjectToAMT,
            .amtIncome,
            .amtExemption,
            .amtPhaseOutTheshold,
            .amtReducedExemption,
            .amtTaxableIncome,
            .amtTax,
            ]
        case .taxRates: return [
            .maginalCapitalGainsTaxRate,
            .marginalOrdinaryTaxRate,
            .averageTaxRate,
            .effectiveTaxRate,
            .provisionalTaxRate
            ]
        case .computedFlags: return [
            .isSubjectToNIIT,
            .isSubjectToFICA,
            .isSubjectToIRMAA,
            .isSubjectToAMT,
            ]
        }
    }
    
}

extension KeyMetricCategories: Displayable {
    var label: String {
        switch self {
        case .profile: return String(localized:"Profile")
        case .income: return String(localized:"Income")
        case .agiAndMagis: return String(localized:"AGI and MAGIS")
        case .investments: return String(localized:"Investments")
        case .socialSecurity: return String(localized:"Social Security")
        case .deductions: return String(localized:"Deductions")
        case .taxes: return String(localized:"Taxes")
        case .wages: return String(localized:"Wages")
        case .taxRates: return String(localized:"Tax Rates")
        case .computedFlags: return String(localized:"Computed Flags")
        case .irmaa: return String(localized:"IRMAA")
        case .amt: return String(localized:"AMT")
        }
    }
    
    var description: String? {
        return nil
    }
}
