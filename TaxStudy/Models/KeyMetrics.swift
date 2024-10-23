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
    case totalSSAIncome
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
    case carryforwardLoss
    case dividends
    case capitalGains
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
    case irmaaSurcharges
    
    // MARK: - Alternative Minimum Tax (AMT)
    case isSubjectToAMT
    case amtIncome
    case amtExemption
    case amtPhaseOutTheshold
    case amtReducedExemption
    case amtTaxableIncome
    case amtTax
}

extension KeyMetricTypes {
    var supported: Bool {
        switch self {
            
        default:
            return false
        }
    }
}

extension KeyMetricTypes : Displayable {
    public var label: String {
        switch self {
            
        case .selfName:
            return String(localized: "Name (self)")
        case .spouseName:
            return String(localized: "Name (spouse)")
        case .selfAge:
            return String(localized: "Age (self)")
        case .spouseAge:
            return String(localized: "Age (spouse)")
        case .selfWages:
            return String(localized: "Wages (self)")
        case .spouseWages:
            return String(localized: "Wages (spouse)")
        case .selfSSI:
            return String(localized: "SSI (self)")
        case .spouseSSI:
            return String(localized: "SSI (spouse)")
        case .selfMedical:
            return String(localized: "Medical (self)")
        case .spouseMedical:
            return String(localized: "Medical (spouse)")
        case .selfEmployement:
            return String(localized: "Employement (self)")
        case .spouseEmployement:
            return String(localized: "Employement (spouse)")
        case .filingStatus:
            return String(localized: "Filing Status")
        case .taxRules:
            return String(localized: "Tax Rules")
        case .grossIncome:
            return String(localized: "Gross Income")
        case .totalIncome:
            return String(localized: "Total Income")
        case .totalDeductionOftype:
            return String(localized: "Total Deduction of Type")
        case .totalAdjustmentOfType:
            return String(localized: "Total Adjustment of Type")
        case .totalCreditsOfType:
            return String(localized: "Total Credits of Type")
        case .totalTaxExemptInterestIncome:
            return String(localized: "Total Tax Exempt Interest Income")
        case .totalExcludedIncome:
            return String(localized: "Total Excluded Income")
        case .totalWages:
            return String(localized: "Total Wages")
        case .totalSSAIncome:
            return String(localized: "Total SSI")
        case .agi:
            return String(localized: "AGI")
        case .agiBeforeSSI:
            return String(localized: "AGI Before SSI")
        case .magiForIRMAA:
            return String(localized: "MAGI for IRMAA")
        case .magiForIRA:
            return String(localized: "MAGI for IRA")
        case .magiForRothIRA:
            return String(localized: "MAGI for Roth IRA")
        case .magiForNIIT:
            return String(localized: "MAGI for NIIT")
        case .magiForACASubsidies:
            return String(localized: "MAGI for ACA Subsidies")
        case .magiForPassiveActivityLossRules:
            return String(localized: "MAGI for Passive Activity Loss Rules")
        case .magiForSocialSecurity:
            return String(localized: "MAGI for Social Security")
        case .interest:
            return String(localized: "Interest Taxable / Exempt")
        case .carryforwardLoss:
            return String(localized: "Carryforward Loss")
        case .dividends:
            return String(localized: "Dividends Qualfied/Ordinary")
        case .totalDividends:
            return String(localized: "Total Dividends")
        case .totalRentalIncome:
            return String(localized: "Total Rental Income")
        case .totalRoyalties:
            return String(localized: "Total Royalties")
        case .totalBusinessIncome:
            return String(localized: "Total Business Income")
        case .totalForeignEarnedIncome:
            return String(localized: "Total Foreign Earned Income")
        case .totalRetirementContributions:
            return String(localized: "Total Retirement Contributions")
        case .capitalGains:
            return String(localized: "Capital Gains STCG/LTCG")
        case .netLTCG:
            return String(localized: "Net LTCG")
        case .netSTCG:
            return String(localized: "Net STCG")
        case .futureCarryForwardLoss:
            return String(localized: "Future Carryforward Loss")
        case .netInvestmentIncome:
            return String(localized: "Net Investment Income (NII)")
        case .capitalLossAdjustment:
            return String(localized: "Capital Loss Adjustment (Last Year)")
        case .provisionalIncome:
            return String(localized: "Provisional Income")
        case .provisionalTaxRate:
            return String(localized: "Provisional Tax Rate")
        case .taxableSSAIncome:
            return String(localized: "Taxable SSA Income")
        case .standardDeduction:
            return String(localized: "Standard Deduction")
        case .deductibleMedicalExpenses:
            return String(localized: "Deductible Medical Expenses")
        case .deductibleCharitableCashContributions:
            return String(localized: "Deductible Charitable Cash Contributions")
        case .deductibleCharitableAssetContributions:
            return String(localized: "Deductible Charitable Asset Contributions")
        case .totalDecutibleChartitableContributions:
            return String(localized: "Total Decutible Chartitable Contributions")
        case .totalItemizedDeductions:
            return String(localized: "Total Itemized Deductions")
        case .deduction:
            return String(localized: "Total Deduction")
        case .deductionMethod:
            return String(localized: "Deduction Method")
        case .taxableIncome:
            return String(localized: "Taxable Income")
        case .preferentialIncome:
            return String(localized: "Preferential Income")
        case .ordinaryIncome:
            return String(localized: "Ordinary Income")
        case .ordinaryIncomeTax:
            return String(localized: "Ordinary Income Tax")
        case .qualifiedDividendTax:
            return String(localized: "Qualified Dividend Tax")
        case .capitalGainsTax:
            return String(localized: "Capital Gains Tax")
        case .netInvestmentIncomeTax:
            return String(localized: "Net Investment Income Tax (NIIT)")
        case .federalTax:
            return String(localized: "Federal Tax")
        case .safeHarborTax:
            return String(localized: "Safe Harbor Tax Quarter/Yearly")
        case .totalFICATax:
            return String(localized: "Total FICA Tax")
        case .totalFICATaxSocialSecurity:
            return String(localized: "Total FICA Tax (Social Security)")
        case .totalFICATaxMedicare:
            return String(localized: "Total FICA Tax (Medicare)")
        case .maginalCapitalGainsTaxRate:
            return String(localized: "Marginal Capital Gains Tax Rate")
        case .marginalOrdinaryTaxRate:
            return String(localized: "Marginal Ordinary Tax Rate")
        case .averageTaxRate:
            return String(localized: "Average Tax Rate")
        case .effectiveTaxRate:
            return String(localized: "Effective Tax Rate")
        case .isSubjectToNIIT:
            return String(localized: "Is Subject to NIIT")
        case .isSubjectToFICA:
            return String(localized: "Is Subject to FICA")
        case .isSubjectToIRMAA:
            return String(localized: "Is Subject to IRMAA")
        case .irmaaPlanDSurcharge:
            return String(localized: "IRMAA Surcharge (Plan D)")
        case .irmaaPlanBSurcharge:
            return String(localized: "IRMAA Surcharge (Plan B)")
        case .irmaaSurcharges:
            return String(localized: "IRMAA Surcharges Plan B / Plan D")
        case .isSubjectToAMT:
            return String(localized: "Is Subject to AMT")
        case .amtIncome:
            return String(localized: "AMT Income")
        case .amtExemption:
            return String(localized: "AMT Exemption")
        case .amtPhaseOutTheshold:
            return String(localized: "AMT Phase Out Threshold")
        case .amtReducedExemption:
            return String(localized: "AMT Reduced Exemption")
        case .amtTaxableIncome:
            return String(localized: "AMT Taxable Income")
        case .amtTax:
            return String(localized: "AMT Tax")
        case .totalIncomeOfType(_):
            return String(localized: "Total Income of Type")
        }
    }
    
    public var description: String? {
        switch self {
            
        default:
            return nil
        }
    }
}


extension KeyMetricTypes : CaseIterable {
    static var allCases: [KeyMetricTypes] {
        return [
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
            .taxRules,
            .grossIncome,
            .totalIncome,
            .totalTaxExemptInterestIncome,
            .totalExcludedIncome,
            .totalWages,
            .totalSSAIncome,
            .agi,
            .agiBeforeSSI,
            .magiForIRMAA,
            .magiForIRA,
            .magiForRothIRA,
            .magiForNIIT,
            .magiForACASubsidies,
            .magiForPassiveActivityLossRules,
            .magiForSocialSecurity,
            .interest,
            .carryforwardLoss,
            .dividends,
            .capitalGains,
            .totalDividends,
            .totalRentalIncome,
            .totalRoyalties,
            .totalBusinessIncome,
            .totalForeignEarnedIncome,
            .totalRetirementContributions,
            .netLTCG,
            .netSTCG,
            .futureCarryForwardLoss,
            .netInvestmentIncome,
            .capitalLossAdjustment,
            .provisionalIncome,
            .provisionalTaxRate,
            .taxableSSAIncome,
            .standardDeduction,
            .deductibleMedicalExpenses,
            .deductibleCharitableCashContributions,
            .deductibleCharitableAssetContributions,
            .totalDecutibleChartitableContributions,
            .totalItemizedDeductions,
            .deduction,
            .deductionMethod,
            .taxableIncome,
            .preferentialIncome,
            .ordinaryIncome,
            .ordinaryIncomeTax,
            .qualifiedDividendTax,
            .capitalGainsTax,
            .netInvestmentIncomeTax,
            .federalTax,
            .safeHarborTax,
            .totalFICATax,
            .totalFICATaxSocialSecurity,
            .totalFICATaxMedicare,
            .maginalCapitalGainsTaxRate,
            .marginalOrdinaryTaxRate,
            .averageTaxRate,
            .effectiveTaxRate,
            .isSubjectToNIIT,
            .isSubjectToFICA,
            .isSubjectToIRMAA,
            .irmaaPlanDSurcharge,
            .irmaaPlanBSurcharge,
            .irmaaSurcharges,
            .isSubjectToAMT,
            .amtIncome,
            .amtExemption,
            .amtPhaseOutTheshold,
            .amtReducedExemption,
            .amtTaxableIncome,
            .amtTax
        ]
    }
}

extension KeyMetricTypes: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.label)
    }
}

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
            .totalExcludedIncome,
            .totalWages,
            .totalSSAIncome,
            .preferentialIncome,
            .ordinaryIncome,
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
            .totalRentalIncome,
            .totalRoyalties,
            .totalBusinessIncome,
            .totalForeignEarnedIncome,
            .totalRetirementContributions,
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
