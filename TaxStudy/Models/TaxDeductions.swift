//
//  Untitled.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/14/24.
//

import Foundation

enum TaxDeductionType: String {
    /// Deduct unreimbursed medical expenses over 7.5% of your AGI.
    case medicalAndDentalDeduction
    
    /// State and Local Taxes (SALT) Up to $10,000 deduction for state and local income, property, and sales taxes.
    /// Property taxes on your primary residence are deductible, as well as on other real estate you own.
    case stateAndLocalTaxDeduction
    
    /// Mortgage Interest Deduction - Deduct interest on mortgages up to $750,000 of acquisition debt for homes
    /// purchased after Dec. 15, 2017.   Includes home equity loans or lines of credit if used to buy, build, or
    /// improve your home.
    case mortgageInterestDeduction
    
    /// Charitable Contributions of Cash: Up to 60% of your AGI.
    case charitableCashContributionDeduction
    
    /// Charitable Contributions of Stock or appreciated assets: Up to 30% of your AGI.
    case charitableAssetContributionDeduction
    
    /// Charitable Contributions of Mileage for charitable activities: 14 cents per mile.
    case charitableMileageContributionDeduction
    
    /// Casualty and Theft Losses - Deduct losses from federally declared disasters, subject to a $500
    /// deductible and other limits.
    case casualtyAndTheftLossDeduction
    
    /// Qualified Business Income (QBI) Deduction: Eligible taxpayers may deduct up to 20%
    /// of qualified business income under IRC §199A, further reducing taxable income.
    case qualifiedBusinessIncomeDeduction
    
    /// Investment Interest - Deduct interest paid on loans used to purchase taxable investments, limited to
    /// the net investment income.
    case marginInterestDeduction
    
    /// Gambling Losses - Deduct gambling losses up to the amount of gambling winnings reported as income.
    case gamblingLossDeduction
    
    /// Long-Term Care Insurance Premiums - Deduct a portion of qualified long-term care insurance premiums
    /// based on age. The deduction limit varies annually.
    case longTermCareInsurancePremiumsDeduction
    
    /// Self-Employed Health Insurance Premiums - Deduct health, dental, and long-term care insurance
    /// premiums paid for you, your spouse, and dependents if you’re self-employed.
    case selfEmployedHealthInsurancePremiumsDeduction
    
    /// Student Loan Interest Deduction - Deduct up to $2,500 of student loan interest if income limits are met.
    case studentLoanInterestDeduction
    
    /// Tuition and Fees Deduction - While expired as of 2020, check for any temporary reinstatement in tax
    /// code changes. Historically allowed up to $4,000 deduction for qualified higher education expenses.
    case tuitionAndFeesDeduction
    
    /// Self-Employment Tax Deduction - Deduct the employer-equivalent portion of self-employment taxes
    /// (i.e., 50% of your SECA taxes).
    case selfEmploymentTaxDeduction
    
    /// Home Office Deduction - If you’re self-employed and use part of your home exclusively for business,
    /// you can deduct related expenses (e.g., utilities, rent, and home depreciation).
    case homeOfficeDeduction
    
    /// Business Expenses for the Self-Employed - Deduct ordinary and necessary business expenses,
    /// including office supplies, equipment, business travel, advertising, and meals (50%).
    case selfEmployedBusinessExpenseDeduction
    
    /// Mileage Deduction for Business - Deduct 65.5 cents per mile for business driving. Alternatively, actual
    /// vehicle expenses (depreciation, maintenance, gas) may be deducted.
    case mileageDeduction
    
    /// Depreciation - Deduct the depreciation of property (such as business property, rental real estate)
    /// under MACRS guidelines.
    case depreciationDeduction
    
    /// Net Operating Loss (NOL) Carryforwards - If your business or other activities result in a net operating
    /// loss, you may be able to carry forward losses to offset future taxable income.
    case netOperatingLossCarryforwardDeduction
    
    /// Catch all deduction for supporting future changes to the tax code.
    case customDeduction
    
}

extension TaxDeductionType: DeductionType {
    var id: String {
        return self.rawValue
    }
    
    var isSupported: Bool {
        switch self {
            
        case .medicalAndDentalDeduction:
            fallthrough
        case .stateAndLocalTaxDeduction:
            fallthrough
        case .mortgageInterestDeduction:
            fallthrough
        case .charitableCashContributionDeduction:
            fallthrough
        case .charitableAssetContributionDeduction:
            fallthrough
        case .charitableMileageContributionDeduction:
            fallthrough
        case .tuitionAndFeesDeduction:
            fallthrough
        case .marginInterestDeduction:
            fallthrough
        case .depreciationDeduction:
            fallthrough
        case .customDeduction:
            return true
        default:
            return false
        }
    }
    
    var label: String {
        switch self {
        case .medicalAndDentalDeduction:
            return String(localized: "Medical and Dental")
        case .stateAndLocalTaxDeduction:
            return String(localized: "State and Local Tax")
        case .mortgageInterestDeduction:
            return String(localized: "Mortgage Interest")
        case .charitableCashContributionDeduction:
            return String(localized: "Charitable Cash Contribution")
        case .charitableAssetContributionDeduction:
            return String(localized: "Charitable Stock or Asset Contribution")
        case .charitableMileageContributionDeduction:
            return String(localized: "Charitable Contribution of Mileage")
        case .casualtyAndTheftLossDeduction:
            return String(localized: "Casualty and Theft Loss")
        case .qualifiedBusinessIncomeDeduction:
            return String(localized: "Qualified Business Income")
        case .marginInterestDeduction:
            return String(localized: "Margin Interest")
        case .gamblingLossDeduction:
            return String(localized: "Gambling Loss")
        case .longTermCareInsurancePremiumsDeduction:
            return String(localized: "Long-Term Care Insurance")
        case .selfEmployedHealthInsurancePremiumsDeduction:
            return String(localized: "Self-Employed Health Insurance")
        case .studentLoanInterestDeduction:
            return String(localized: "Student Loan Interest")
        case .tuitionAndFeesDeduction:
            return String(localized: "Tuition and Fees")
        case .selfEmploymentTaxDeduction:
            return String(localized: "Self-Employment Tax")
        case .homeOfficeDeduction:
            return String(localized: "Home Office")
        case .selfEmployedBusinessExpenseDeduction:
            return String(localized: "Self-Employed Business Expense")
        case .mileageDeduction:
            return String(localized: "Mileage")
        case .depreciationDeduction:
            return String(localized: "Depreciation")
        case .netOperatingLossCarryforwardDeduction:
            return String(localized: "Net Operating Loss Carryforward")
        case .customDeduction:
            return String(localized: "Other Deduction")
        }
    }
    
    var description: String {
        switch self {
        case .medicalAndDentalDeduction:
            return String(localized: "Deduct unreimbursed medical expenses over 7.5% of your AGI.")
        case .stateAndLocalTaxDeduction:
            return String(localized: "Deduct up to $10,000 in state and local income, property, and sales taxes, including property taxes on your primary residence.")
        case .mortgageInterestDeduction:
            return String(localized: "Deduct interest on up to $750,000 of mortgage debt, including home equity loans used for home improvements.")
        case .charitableCashContributionDeduction:
            return String(localized: "Deduct cash contributions up to 60% of your AGI")
        case .charitableAssetContributionDeduction:
            return String(localized: "Deduct charitable asset contributions up to 30% of your AGI")
        case .charitableMileageContributionDeduction:
            return String(localized: "Deduct mileage driven for a charitable purpose at a rate of $0.14 per mile")
        case .casualtyAndTheftLossDeduction:
            return String(localized: "Deduct losses from federally declared disasters, subject to limits such as a $500 deductible.")
        case .qualifiedBusinessIncomeDeduction:
            return String(localized: "Deduct up to 20% of qualified business income for eligible taxpayers under IRC §199A.")
        case .marginInterestDeduction:
            return String(localized: "Deduct interest paid on loans used to purchase taxable investments, limited to net investment income.")
        case .gamblingLossDeduction:
            return String(localized: "Deduct gambling losses up to the amount of reported gambling winnings.")
        case .longTermCareInsurancePremiumsDeduction:
            return String(localized: "Deduct a portion of qualified long-term care insurance premiums, based on your age.")
        case .selfEmployedHealthInsurancePremiumsDeduction:
            return String(localized: "Deduct health, dental, and long-term care premiums if you're self-employed.")
        case .studentLoanInterestDeduction:
            return String(localized: "Deduct up to $2,500 of student loan interest, subject to income limits.")
        case .tuitionAndFeesDeduction:
            return String(localized: "Check for temporary reinstatement of this deduction, which previously allowed up to $4,000 for qualified education expenses.")
        case .selfEmploymentTaxDeduction:
            return String(localized: "Deduct 50% of your self-employment taxes (SECA).")
        case .homeOfficeDeduction:
            return String(localized: "Deduct expenses for the part of your home used exclusively for business, if self-employed.")
        case .selfEmployedBusinessExpenseDeduction:
            return String(localized: "Deduct necessary business expenses like supplies, travel, and meals (50%), if self-employed.")
        case .mileageDeduction:
            return String(localized: "Deduct 65.5 cents per mile for business driving or actual vehicle expenses.")
        case .depreciationDeduction:
            return String(localized: "Deduct depreciation on business or rental property following MACRS guidelines.")
        case .netOperatingLossCarryforwardDeduction:
            return String(localized: "Carry forward business losses to offset future taxable income.")
        case .customDeduction:
            return String(localized: "A placeholder deduction for future changes in the tax code.")
        }
    }
}
