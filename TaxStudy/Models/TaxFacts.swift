//
//  TaxFacts.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/13/24.
//

import Foundation

/// Collection of tax brackets and other contraints and limits that are used in computing the taxes for a given year.
class TaxFacts : Codable, Identifiable {
    var id: String = UUID().uuidString
    var year: Int? = 2024
    var ordinaryTaxBrackets: TaxBrackets
    var capitalGainTaxBrackets: TaxBrackets
    
    /// The FICA Income thresholds for Social Security Taxes
    var ssTaxThresholds: TaxBrackets
    /// The FICA income thresholds for Medicare Taxes
    var medicareTaxThresholds: TaxBrackets
    
    var provisionalIncomeThresholds: TaxBrackets
    
    /// IRMAA (Plan B)
    var irmaaPlanBThresholds: TaxBrackets
    var irmaaPlanDThresholds: TaxBrackets
    
    var niitThresholds: [FilingStatus: Double]
    var niitRate: Double
    
    var capitalLossLimit: Double // 3000
    
    var standardDeduction: [FilingStatus: Double]
    var standardDeductionBonus: [FilingStatus: Double]
    var standardDeductionBonusAge: Int
    
    var charitableCashThreadholdRate: Double = 0.6
    var charitableAssetThreadholdRate: Double = 0.3
    var charitableMileageRate: Double = 0.14
    
    init(
        id: String? = nil,
        year: Int? = 2024,
        ordinaryTaxBrackets: TaxBrackets,
        capitalGainTaxBrackets: TaxBrackets,
        ssTaxThresholds: TaxBrackets,
        medicareTaxThresholds: TaxBrackets,
        provisionalIncomeThresholds: TaxBrackets,
        irmaaPlanBThresholds: TaxBrackets,
        irmaaPlanDThresholds: TaxBrackets,
        niitThresholds: [FilingStatus : Double],
        niitRate: Double,
        standardDeduction: [FilingStatus : Double],
        startardDeductionBonus: [FilingStatus : Double],
        standardDeductionBonusAge: Int,
        capitalLossLimit: Double
    ) {
        self.id = id ?? UUID().uuidString
        self.year = year
        self.ordinaryTaxBrackets = ordinaryTaxBrackets
        self.capitalGainTaxBrackets = capitalGainTaxBrackets
        self.ssTaxThresholds = ssTaxThresholds
        self.medicareTaxThresholds = medicareTaxThresholds
        self.provisionalIncomeThresholds = provisionalIncomeThresholds
        self.irmaaPlanBThresholds = irmaaPlanBThresholds
        self.irmaaPlanDThresholds = irmaaPlanDThresholds
        self.niitThresholds = niitThresholds
        self.niitRate = niitRate
        self.capitalLossLimit = capitalLossLimit
        self.standardDeduction = standardDeduction
        self.standardDeductionBonus = startardDeductionBonus
        self.standardDeductionBonusAge = standardDeductionBonusAge
    }
}

let DefaultTaxFacts2024 = TaxFacts(
    id: "OfficialTaxFacts2024",
    year: 2024,
    ordinaryTaxBrackets: OrdinaryTaxBrackets2024,
    capitalGainTaxBrackets: CapitalGainTaxBrackets2024,
    ssTaxThresholds: SSTaxThresholds2024,
    medicareTaxThresholds: MedicareTaxThresholds2024,
    provisionalIncomeThresholds: ProvisionalIncomeThresholds2024,
    irmaaPlanBThresholds: PlanBSurchargethresholds2024,
    irmaaPlanDThresholds: PlanDSurchargethresholds2024,
    niitThresholds: [
        .single: 200_000,
        .marriedFilingJointly: 250_000,
        .marriedFilingSeparately: 125_000,
        .headOfHousehold: 200_000,
        .qualifiedWidow: 250_000
    ],
    niitRate: 0.038,
    standardDeduction: [
        .single: 14_600,
        .marriedFilingSeparately: 14_600,
        .marriedFilingJointly: 29_200,
        .qualifiedWidow: 29_200,
        .headOfHousehold: 21_900
    ],
    startardDeductionBonus: [
        .single: 1_950,
        .marriedFilingSeparately: 1_550,
        .marriedFilingJointly: 1_550,
        .qualifiedWidow: 1_950,
        .headOfHousehold: 1_950
    ],
    standardDeductionBonusAge: 65,
    capitalLossLimit: 3000
//    ssdiThreshold: 34000
)
