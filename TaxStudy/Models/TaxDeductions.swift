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
    
    /// Charitable Contributions
    /// - Deduct contributions made to qualified charitable organizations. These can be:
    /// - Cash contributions: Up to 60% of your AGI.
    /// - Stock or appreciated assets: Up to 30% of your AGI.
    /// - Donor-Advised Fund (DAF) contributions: Generally treated as charitable contributions.
    /// - Mileage for charitable activities: 14 cents per mile.
    case charitableContributionDeduction
    
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
    
    /// Tax Preparation Fees - Deducted as a business expense if self-employed. Otherwise, no longer
    /// deductible for individual filers.
    case taxPreparationFeeDeduction
    
    /// Investment and Advisory Fees (Pre-2018) - Some unreimbursed investment-related expenses may be
    /// deductible as a miscellaneous deduction, but the ability to deduct this has been suspended for
    /// tax years 2018 through 2025 under the TCJA.
    case investmentAndAdvisoryFeeDeduction
    
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
    var label: String {
        return ""
    }
    
    var description: String {
        return ""
    }
}
