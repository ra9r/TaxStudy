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
    case totalAdjustments
    case totalWages
    case totalSSAIncome
    case totalDividends
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
        case .totalAdjustments:
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
            return String(localized: "Interest Exempt / Taxable")
        case .carryforwardLoss:
            return String(localized: "Carryforward Loss")
        case .dividends:
            return String(localized: "Dividends Qualfied/Ordinary")
        case .totalDividends:
            return String(localized: "Total Dividends")
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

extension KeyMetricTypes: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.label)
    }
}

extension KeyMetricTypes {
    func resolve(for scenario: TaxScenario, facts: TaxFacts) throws -> String {
        let fedTax = FederalTaxCalc(scenario, facts: facts)
        switch self {
            
        case .selfName:
            return scenario.profileSelf.name
        case .spouseName:
            return scenario.profileSpouse.name
        case .selfAge:
            return "\(scenario.profileSelf.age)"
        case .spouseAge:
            return "\(scenario.profileSpouse.age)"
        case .selfWages:
            return scenario.profileSelf.wages.asCurrency(0)
        case .spouseWages:
            return scenario.profileSpouse.wages.asCurrency(0)
        case .selfSSI:
            return scenario.profileSelf.socialSecurity.asCurrency(0)
        case .spouseSSI:
            return scenario.profileSpouse.socialSecurity.asCurrency(0)
        case .selfMedical:
            return scenario.profileSelf.medicalCoverage.label
        case .spouseMedical:
            return scenario.profileSpouse.medicalCoverage.label
        case .selfEmployement:
            return scenario.profileSelf.employmentStatus.label
        case .spouseEmployement:
            return scenario.profileSpouse.employmentStatus.label
        case .filingStatus:
            return scenario.filingStatus.label
        case .taxRules:
            return scenario.facts
        case .grossIncome:
            return fedTax.grossIncome.asCurrency(0)
        case .totalIncome:
            return fedTax.totalIncome.asCurrency(0)
        case .totalTaxExemptInterestIncome:
            return fedTax.totalTaxExemptIncome.asCurrency(0)
        case .totalAdjustments:
            return scenario.totalAdjustments.asCurrency(0)
        case .totalWages:
            return scenario.totalWages.asCurrency(0)
        case .totalSSAIncome:
            return scenario.totalSocialSecurityIncome.asCurrency(0)
        case .totalIncomeOfType(let incomeType):
            return scenario.income.total(for: incomeType).asCurrency(0)
        case .totalDeductionOftype(let deductionType):
            return scenario.deductions.total(for: deductionType).asCurrency(0)
        case .totalAdjustmentOfType(let adjustmentType):
            return scenario.adjustments.total(for: adjustmentType).asCurrency(0)
        case .totalCreditsOfType(let creditType):
            return scenario.credits.total(for: creditType).asCurrency(0)
        case .agi:
            return fedTax.agi.asCurrency(0)
        case .agiBeforeSSI:
            return fedTax.agiBeforeSSI.asCurrency(0)
        case .magiForIRMAA:
            return fedTax.magiForIRMAA.asCurrency(0)
        case .magiForIRA:
            return fedTax.magiForIRA.asCurrency(0)
        case .magiForRothIRA:
            return fedTax.magiForRothIRA.asCurrency(0)
        case .magiForNIIT:
            return fedTax.magiForNIIT.asCurrency(0)
        case .magiForACASubsidies:
            return fedTax.magiForACASubsidies.asCurrency(0)
        case .magiForPassiveActivityLossRules:
            return fedTax.magiForPassiveActivityLossRules.asCurrency(0)
        case .magiForSocialSecurity:
            return fedTax.magiForSocialSecurity.asCurrency(0)
        case .interest:
            let exemptInterest = fedTax.totalTaxExemptIncome.asCurrency(0)
            let taxableInterst = scenario.income.total(for: .interest).asCurrency(0)
            return "\(exemptInterest) / \(taxableInterst)"
        case .carryforwardLoss:
            return scenario.carryforwardLoss.asCurrency(0)
        case .dividends:
            return "\(scenario.qualifiedDividends) / \(scenario.ordinaryDividends)"
        case .capitalGains:
            return "\(fedTax.netSTCG) / \(fedTax.netLTCG)"
        case .totalDividends:
            return scenario.totalDividends.asCurrency(0)
        case .netLTCG:
            return fedTax.netLTCG.asCurrency(0)
        case .netSTCG:
            return fedTax.netSTCG.asCurrency(0)
        case .futureCarryForwardLoss:
            return fedTax.futureCarryForwardLoss.asCurrency(0)
        case .netInvestmentIncome:
            return fedTax.netInvestmentIncome.asCurrency(0)
        case .capitalLossAdjustment:
            return fedTax.capitalLossAdjustment.asCurrency(0)
        case .provisionalIncome:
            return fedTax.provisionalIncome.asCurrency(0)
        case .provisionalTaxRate:
            return fedTax.provisionalTaxRate.asPercentage
        case .taxableSSAIncome:
            return fedTax.taxableSSI.asCurrency(0)
        case .standardDeduction:
            return fedTax.standardDeduction.asCurrency(0)
        case .deductibleMedicalExpenses:
            return fedTax.deductibleMedicalExpenses.asCurrency(0)
        case .deductibleCharitableCashContributions:
            return fedTax.deductibleCharitableCashContributions.asCurrency(0)
        case .deductibleCharitableAssetContributions:
            return fedTax.deductibleCharitableAssetContributions.asCurrency(0)
        case .totalDecutibleChartitableContributions:
            return fedTax.totalChartitableContributions.asCurrency(0)
        case .totalItemizedDeductions:
            return fedTax.totalItemizedDeductions.asCurrency(0)
        case .deduction:
            return fedTax.deduction.asCurrency(0)
        case .deductionMethod:
            return fedTax.deductionMethod
        case .taxableIncome:
            return fedTax.taxableIncome.asCurrency(0)
        case .preferentialIncome:
            return fedTax.preferentialIncome.asCurrency(0)
        case .ordinaryIncome:
            return fedTax.ordinaryIncome.asCurrency(0)
        case .ordinaryIncomeTax:
            return fedTax.ordinaryIncomeTax.asCurrency(0)
        case .qualifiedDividendTax:
            return fedTax.qualifiedDividendTax.asCurrency(0)
        case .capitalGainsTax:
            return fedTax.capitalGainsTax.asCurrency(0)
        case .netInvestmentIncomeTax:
            return fedTax.netInvestmentIncomeTax.asCurrency(0)
        case .federalTax:
            return fedTax.federalTax.asCurrency(0)
        case .safeHarborTax:
            let safeHarborTax = fedTax.safeHarborTax
            return "\((safeHarborTax/4).asCurrency(0)) / \(safeHarborTax.asCurrency(0))"
        case .totalFICATax:
            return fedTax.totalFICATax.asCurrency(0)
        case .totalFICATaxSocialSecurity:
            return fedTax.totalFICATaxSocialSecurity.asCurrency(0)
        case .totalFICATaxMedicare:
            return fedTax.totalFICATaxMedicare.asCurrency(0)
        case .maginalCapitalGainsTaxRate:
            return fedTax.maginalCapitalGainsTaxRate.asCurrency(0)
        case .marginalOrdinaryTaxRate:
            return fedTax.marginalOrdinaryTaxRate.asCurrency(0)
        case .averageTaxRate:
            return fedTax.averageTaxRate.asCurrency(0)
        case .effectiveTaxRate:
            return "??" // TODO: Implement .effectiveTaxRate
        case .isSubjectToNIIT:
            return fedTax.isSubjectToNIIT ? "Yes" : "No"
        case .isSubjectToFICA:
            return fedTax.isSubjectToFICA ? "Yes" : "No"
        case .isSubjectToIRMAA:
            return fedTax.isSubjectToAMT ? "Yes" : "No"
        case .irmaaPlanDSurcharge:
            return fedTax.irmaaPlanDSurcharge.asCurrency(0)
        case .irmaaPlanBSurcharge:
            return fedTax.irmaaPlanBSurcharge.asCurrency(0)
        case .irmaaSurcharges:
            let planB = fedTax.irmaaPlanBSurcharge.asCurrency(0)
            let planD =  fedTax.irmaaPlanDSurcharge.asCurrency(0)
            return "\(planB) / \(planD)"
        case .isSubjectToAMT:
            return fedTax.isSubjectToAMT ? "Yes" : "No"
        case .amtIncome:
            return fedTax.amtIncome.asCurrency(0)
        case .amtExemption:
            return fedTax.amtExemption.asCurrency(0)
        case .amtPhaseOutTheshold:
            return fedTax.amtPhaseOutTheshold.asCurrency(0)
        case .amtReducedExemption:
            return fedTax.amtReducedExemption.asCurrency(0)
        case .amtTaxableIncome:
            return fedTax.amtTaxableIncome.asCurrency(0)
        case .amtTax:
            return fedTax.amtTax.asCurrency(0)
            
        }
    }
}
