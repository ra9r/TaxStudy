//
//  KeyMetricCategories.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/23/24.
//


enum KeyMetricCategories: String, CaseIterable {
    case profile
    case income
    case adjustments
    case credits
    case deductions
    case agiAndMagis
    case investments
    case socialSecurity
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
            .totalIncomeOfType(.businessIncome),
            .totalIncomeOfType(.interest),
            .totalIncomeOfType(.taxExemptInterest),
            .totalIncomeOfType(.shortTermCapitalGains),
            .totalIncomeOfType(.longTermCapitalGains),
            .totalIncomeOfType(.carryforwardLoss),
            .totalIncomeOfType(.qualifiedDividends),
            .totalIncomeOfType(.ordinaryDividends),
            .totalIncomeOfType(.rentalIncome),
            .totalIncomeOfType(.royalties),
            .totalIncomeOfType(.foreignEarnedIncome),
            .totalIncomeOfType(.otherOrdinaryIncome),
            .totalIncomeOfType(.iraWithdrawal),
            .totalIncomeOfType(.rothConversion),
            .totalIncomeOfType(.qualifiedHSADistributions),
            .totalIncomeOfType(.rothDistributions),
            .totalIncomeOfType(.giftsOrInheritance),
            .totalIncomeOfType(.otherTaxExemptIncome),
            ]
        case .adjustments: return [
            .totalAdjustmentOfType(.iraOr401kContribution),
            .totalAdjustmentOfType(.hsaContribution),
            .totalAdjustmentOfType(.studentLoanInterest),
            .totalAdjustmentOfType(.businessExpenses),
            .totalAdjustmentOfType(.earlyWithDrawalPenalties),
            .totalAdjustmentOfType(.foreignEarnedIncomeExclusion),
            .totalAdjustmentOfType(.foreignHousingExclusion),
            .totalAdjustmentOfType(.customAdjustment),
        ]
        case .credits: return [
            .totalCreditsOfType(.childTaxCredit),
            .totalCreditsOfType(.earnedIncomeTaxCredit),
            .totalCreditsOfType(.americanOpportunityTaxCredit),
            .totalCreditsOfType(.lifetimeLearningCredit),
            .totalCreditsOfType(.saversCredit),
            .totalCreditsOfType(.foreignTaxCredit),
            .totalCreditsOfType(.adoptionCredit),
            .totalCreditsOfType(.premiumTaxCredit),
            .totalCreditsOfType(.residentialRenewableEnergyCredit),
            .totalCreditsOfType(.energyEfficiencyImprovementCredit),
            .totalCreditsOfType(.plugInElectricVehicleCredit),
            .totalCreditsOfType(.dependentCareCredit),
            .totalCreditsOfType(.childAndDependencyCareCredit),
            .totalCreditsOfType(.healthCoverageTaxCredit),
            .totalCreditsOfType(.workOpportunityTaxCredit),
            .totalCreditsOfType(.elderlyOrDisabledTaxCredit),
            .totalCreditsOfType(.customCredit),
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
            .totalDeductionOfType(.medicalAndDentalDeduction),
            .totalDeductionOfType(.stateAndLocalTaxDeduction),
            .totalDeductionOfType(.mortgageInterestDeduction),
            .totalDeductionOfType(.charitableCashContributionDeduction),
            .totalDeductionOfType(.charitableAssetContributionDeduction),
            .totalDeductionOfType(.charitableMileageContributionDeduction),
            .totalDeductionOfType(.casualtyAndTheftLossDeduction),
            .totalDeductionOfType(.qualifiedBusinessIncomeDeduction),
            .totalDeductionOfType(.marginInterestDeduction),
            .totalDeductionOfType(.gamblingLossDeduction),
            .totalDeductionOfType(.longTermCareInsurancePremiumsDeductions),
            .totalDeductionOfType(.rentalPropertyExpensesDeduction),
            .totalDeductionOfType(.selfEmployedHealthInsurancePremiumsDeduction),
            .totalDeductionOfType(.studentLoanInterestDeduction),
            .totalDeductionOfType(.tuitionAndFeesDeduction),
            .totalDeductionOfType(.selfEmploymentTaxDeduction),
            .totalDeductionOfType(.homeOfficeDeduction),
            .totalDeductionOfType(.selfEmployedBusinessExpenseDeduction),
            .totalDeductionOfType(.mileageDeduction),
            .totalDeductionOfType(.depreciationDeduction),
            .totalDeductionOfType(.netOperatingLossCarryforwardDeduction),
            .totalDeductionOfType(.customDeduction),
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
            .marginalCapitalGainsTaxRate,
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
        case .adjustments: return String(localized:"Adjustments")
        case .credits: return String(localized:"Credits")
        }
    }
    
    var description: String? {
        return nil
    }
}
