//
//  TaxFacts.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/13/24.
//

import Foundation

class TaxFacts : Codable, Identifiable {
    var id: String
    
    // Standard Deduction
    var standardDeduction: [FilingStatus: Double]
    var standardDeductionBonus: [FilingStatus: Double]
    var standardDeductionBonusAge: Int
    
    // Net Investment Income
    var niitThresholds: [FilingStatus: Double]
    var niitRate: Double
    
    // Ordinary Income Tax
    var ordinaryTaxBrackets: TaxBrackets
    
    // Capital Gains Tax
    var capitalGainTaxBrackets: TaxBrackets
    var capitalLossLimit: Double // 3000
    
    // The FICA Income thresholds for Social Security Taxes and  Medicare Taxes
    var ssTaxThresholds: TaxBrackets
    var medicareTaxThresholds: TaxBrackets
    
    
    // Provision Income (used in Social Security Tax calculations)
    var provisionalIncomeThresholds: TaxBrackets
    
    // IRMAA (Plan B)
    var irmaaPlanBThresholds: TaxBrackets
    var irmaaPlanDThresholds: TaxBrackets
    
    // AMT Facts
    var amtExemptionReductionRate: Double = 0.25
    var amtExemptions: [FilingStatus: Double]
    var amtPhaseOutThesholds: [FilingStatus: Double]
    var amtBrackets: TaxBrackets
    
    var charitableCashThreadholdRate: Double = 0.6
    var charitableAssetThreadholdRate: Double = 0.3
    var charitableMileageRate: Double = 0.14
    var medicalDeductionThreasholdRate: Double = 0.075
    var medicalDeductionThreasholdRateForAMT: Double = 0.10
    
    init(
        id: String,
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
        standardDeductionBonus: [FilingStatus : Double],
        standardDeductionBonusAge: Int,
        capitalLossLimit: Double,
        amtExemptionReductionRate: Double,
        amtExemptions: [FilingStatus: Double],
        amtPhaseOutThesholds: [FilingStatus: Double],
        amtBrackets: TaxBrackets
    ) {
        self.id = id
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
        self.standardDeductionBonus = standardDeductionBonus
        self.standardDeductionBonusAge = standardDeductionBonusAge
        self.amtExemptions = amtExemptions
        self.amtPhaseOutThesholds = amtPhaseOutThesholds
        self.amtExemptionReductionRate = amtExemptionReductionRate
        self.amtBrackets = amtBrackets
    }
}

extension TaxFacts : Hashable, Equatable {
    static func == (lhs: TaxFacts, rhs: TaxFacts) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: - Static Definitions
extension TaxFacts {
    static func createNewTaxFacts(id: String) -> TaxFacts {
        return TaxFacts(
            id: id,
            ordinaryTaxBrackets: OrdinaryTaxBrackets2024,
            capitalGainTaxBrackets: CapitalGainTaxBrackets2024,
            ssTaxThresholds: SSTaxThresholds2024,
            medicareTaxThresholds: MedicareTaxThresholds2024,
            provisionalIncomeThresholds: ProvisionalIncomeThresholds2024,
            irmaaPlanBThresholds: PlanBSurchargethresholds2024,
            irmaaPlanDThresholds: PlanDSurchargethresholds2024,
            niitThresholds: NIITThresholds,
            niitRate: 0.038,
            standardDeduction: StandardDeductions,
            standardDeductionBonus: StandardDeductionBonuses,
            standardDeductionBonusAge: 65,
            capitalLossLimit: 3000,
            amtExemptionReductionRate: 0.25,
            amtExemptions: AMTExemptions,
            amtPhaseOutThesholds: AMTPhaseOutThesholds,
            amtBrackets: AMTBrackets
        )
    }
    
    static let official2024 = TaxFacts(
        id: "2024",
        ordinaryTaxBrackets: OrdinaryTaxBrackets2024,
        capitalGainTaxBrackets: CapitalGainTaxBrackets2024,
        ssTaxThresholds: SSTaxThresholds2024,
        medicareTaxThresholds: MedicareTaxThresholds2024,
        provisionalIncomeThresholds: ProvisionalIncomeThresholds2024,
        irmaaPlanBThresholds: PlanBSurchargethresholds2024,
        irmaaPlanDThresholds: PlanDSurchargethresholds2024,
        niitThresholds: NIITThresholds,
        niitRate: 0.038,
        standardDeduction: StandardDeductions,
        standardDeductionBonus: StandardDeductionBonuses,
        standardDeductionBonusAge: 65,
        capitalLossLimit: 3000,
        amtExemptionReductionRate: 0.25,
        amtExemptions: AMTExemptions,
        amtPhaseOutThesholds: AMTPhaseOutThesholds,
        amtBrackets: AMTBrackets
    )
}


// MARK: - Default Brackets & Thresholds

private let AMTBrackets = TaxBrackets (
    .init(0.26, thresholds: [
        .single: 0,
        .marriedFilingJointly: 0,
        .marriedFilingSeparately: 0,
        .headOfHousehold: 0,
    ]),
    .init(0.28, thresholds: [
        .single: 220_700,
        .marriedFilingJointly: 220_700 * 2.0,
        .marriedFilingSeparately: 110_350,
        .headOfHousehold: 227_700,
    ])
)

private let AMTPhaseOutThesholds: [FilingStatus : Double] = [
    .single: 578_150,
    .marriedFilingJointly: 1_156_300,
    .marriedFilingSeparately: 578_150,
    .headOfHousehold: 578_150,
]

private let AMTExemptions: [FilingStatus : Double] = [
    .single: 81_300,
    .marriedFilingJointly: 126_500,
    .marriedFilingSeparately: 63_250,
    .headOfHousehold: 81_300,
]

private let StandardDeductionBonuses: [FilingStatus : Double] = [
    .single: 1_950,
    .marriedFilingSeparately: 1_550,
    .marriedFilingJointly: 1_550,
    .qualifiedWidow: 1_950,
    .headOfHousehold: 1_950
]

private let StandardDeductions: [FilingStatus : Double] = [
    .single: 14_600,
    .marriedFilingSeparately: 14_600,
    .marriedFilingJointly: 29_200,
    .qualifiedWidow: 29_200,
    .headOfHousehold: 21_900
]

private let NIITThresholds: [FilingStatus : Double] = [
    .single: 200_000,
    .marriedFilingJointly: 250_000,
    .marriedFilingSeparately: 125_000,
    .headOfHousehold: 200_000,
    .qualifiedWidow: 250_000
]

private let OrdinaryTaxBrackets2024 = TaxBrackets(
    .init(0.10, thresholds: [
        .single: 0,
        .marriedFilingJointly: 0,
        .marriedFilingSeparately: 0,
        .headOfHousehold: 0,
        .qualifiedWidow: 0
    ]),
    .init(0.12, thresholds: [
        .single: 11_600,
        .marriedFilingJointly: 23_201,
        .marriedFilingSeparately: 0,
        .headOfHousehold: 16_550,
        .qualifiedWidow: 0
    ]),
    .init(0.22, thresholds: [
        .single: 47_150,
        .marriedFilingJointly: 94_301,
        .marriedFilingSeparately: 0,
        .headOfHousehold: 63_101,
        .qualifiedWidow: 0
    ]),
    .init(0.24, thresholds: [
        .single: 100_525,
        .marriedFilingJointly: 201_051,
        .marriedFilingSeparately: 0,
        .headOfHousehold: 100_501,
        .qualifiedWidow: 0
    ]),
    .init(0.32, thresholds: [
        .single: 191_950,
        .marriedFilingJointly: 383_901,
        .marriedFilingSeparately: 0,
        .headOfHousehold: 191_951,
        .qualifiedWidow: 0
    ]),
    .init(0.35, thresholds: [
        .single: 234_726,
        .marriedFilingJointly: 487_451,
        .marriedFilingSeparately: 0,
        .headOfHousehold: 243_701,
        .qualifiedWidow: 0
    ]),
    .init(0.37, thresholds: [
        .single: 609_351,
        .marriedFilingJointly: 731_201,
        .marriedFilingSeparately: 0,
        .headOfHousehold: 609_351,
        .qualifiedWidow: 0
    ])
)

private let CapitalGainTaxBrackets2024 = TaxBrackets(
    .init(0.0, thresholds: [
        .single: 0,
        .marriedFilingJointly: 0,
        .marriedFilingSeparately: 0,
        .headOfHousehold: 0,
        .qualifiedWidow: 0
    ]),
    .init(0.15, thresholds: [
        .single: 47_026,
        .marriedFilingJointly: 94_051,
        .marriedFilingSeparately: 0,
        .headOfHousehold: 63_001,
        .qualifiedWidow: 0
    ]),
    .init(0.20, thresholds: [
        .single: 518_901,
        .marriedFilingJointly: 583_751,
        .marriedFilingSeparately: 0,
        .headOfHousehold: 551_351,
        .qualifiedWidow: 0
    ])
)

private let SSTaxThresholds2024 = TaxBrackets(
    .init(0.062, thresholds: [
        .single: 0,
        .marriedFilingJointly: 0,
        .marriedFilingSeparately: 0,
        .headOfHousehold: 0,
        .qualifiedWidow: 0
    ]),
    .init(0.0, thresholds: [
        .single: 168_600,
        .marriedFilingJointly: 168_600,
        .marriedFilingSeparately: 168_600,
        .headOfHousehold: 168_600,
        .qualifiedWidow: 168_600
    ]),
    ascending: false
)

private let MedicareTaxThresholds2024 = TaxBrackets(
    .init(0.029, thresholds: [
        .single: 0,
        .marriedFilingJointly: 0,
        .marriedFilingSeparately: 0,
        .headOfHousehold: 0,
        .qualifiedWidow: 0
    ]),
    .init(0.009, thresholds: [
        .single: 200_000,
        .marriedFilingJointly: 250_000,
        .marriedFilingSeparately: 125_000,
        .headOfHousehold: 200_000,
        .qualifiedWidow: 200_000
    ]),
    ascending: false
)

private let ProvisionalIncomeThresholds2024 = TaxBrackets(
    .init(0.0, thresholds: [
        .single: 0,
        .marriedFilingJointly: 0,
        .marriedFilingSeparately: 0,
        .headOfHousehold: 0,
        .qualifiedWidow: 0
    ]),
    .init(0.5, thresholds: [
        .single: 25_000,
        .marriedFilingJointly: 32_000,
        .marriedFilingSeparately: 25_000,
        .headOfHousehold: 25_000,
        .qualifiedWidow: 32_000
    ]),
    .init(0.85, thresholds: [
        .single: 34_000,
        .marriedFilingJointly: 44_000,
        .marriedFilingSeparately: 34_000,
        .headOfHousehold: 34_000,
        .qualifiedWidow: 44_000
    ])
)

private let PlanBSurchargethresholds2024 = TaxBrackets(
    .init(0.0, thresholds: [
        .single: 0,
        .marriedFilingJointly: 0,
        .marriedFilingSeparately: 0,
        .headOfHousehold: 0,
        .qualifiedWidow: 0
    ]),
    .init(70.0, thresholds: [
        .single: 103000,
        .marriedFilingJointly: 206000,
        .marriedFilingSeparately: 103000,
        .headOfHousehold: 103000,
        .qualifiedWidow: 103000
    ]),
    .init(175.0, thresholds: [
        .single: 123000,
        .marriedFilingJointly: 246000,
        .marriedFilingSeparately: 123000,
        .headOfHousehold: 123000,
        .qualifiedWidow: 123000
    ]),
    .init(280.0, thresholds: [
        .single: 153000,
        .marriedFilingJointly: 306000,
        .marriedFilingSeparately: 153000,
        .headOfHousehold: 153000,
        .qualifiedWidow: 153000
    ]),
    .init(285, thresholds: [
        .single: 183000,
        .marriedFilingJointly: 366000,
        .marriedFilingSeparately: 183000,
        .headOfHousehold: 183000,
        .qualifiedWidow: 183000
    ]),
    .init(280.0, thresholds: [
        .single: 500000,
        .marriedFilingJointly: 750000,
        .marriedFilingSeparately: 500000,
        .headOfHousehold: 500000,
        .qualifiedWidow: 500000
    ])
)

private let PlanDSurchargethresholds2024 = TaxBrackets(
    .init(0.0, thresholds: [
        .single: 0,
        .marriedFilingJointly: 0,
        .marriedFilingSeparately: 0,
        .headOfHousehold: 0,
        .qualifiedWidow: 0
    ]),
    .init(12.0, thresholds: [
        .single: 103000,
        .marriedFilingJointly: 206000,
        .marriedFilingSeparately: 103000,
        .headOfHousehold: 103000,
        .qualifiedWidow: 103000
    ]),
    .init(31.0, thresholds: [
        .single: 123000,
        .marriedFilingJointly: 246000,
        .marriedFilingSeparately: 123000,
        .headOfHousehold: 123000,
        .qualifiedWidow: 123000
    ]),
    .init(50.0, thresholds: [
        .single: 153000,
        .marriedFilingJointly: 306000,
        .marriedFilingSeparately: 153000,
        .headOfHousehold: 153000,
        .qualifiedWidow: 153000
    ]),
    .init(70.0, thresholds: [
        .single: 183000,
        .marriedFilingJointly: 366000,
        .marriedFilingSeparately: 183000,
        .headOfHousehold: 183000,
        .qualifiedWidow: 183000
    ]),
    .init(76.0, thresholds: [
        .single: 500000,
        .marriedFilingJointly: 750000,
        .marriedFilingSeparately: 500000,
        .headOfHousehold: 500000,
        .qualifiedWidow: 500000
    ])
)
