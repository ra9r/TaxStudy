//
//  IncomeSource.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/16/24.
//
import SwiftUI

enum IncomeType: String, Codable, CaseIterable {
    // MARK: - Wages
    
    /// Wages earned by the filer
    case wagesSelf
    /// Wages earned by the spouse
    case wagesSpouse
    
    // MARK: - Social Security
    
    /// Social Security benefits received by the filer
    case socialSecuritySelf
    /// Social Security benefits received by the spouse
    case socialSecuritySpouse
    
    // MARK: - Investment Income (Schedule D)
    
    /// Interest income (taxable)
    case interest
    /// Interest income exempt from federal taxes
    case taxExemptInterest
    
    /// Gains from short-term investments (held less than a year)
    case shortTermCapitalGains
    /// Gains from long-term investments (held more than a year)
    case longTermCapitalGains
    /// Losses carried forward from previous years
    case carryforwardLoss
    /// Dividends eligible for preferential tax rates
    case qualifiedDividends
    /// Total ordinary dividends, including qualified and non-qualified
    case totalOrdinaryDividends
    
    // MARK: - Misc Ordinary Income
    
    /// Income from rental properties
    case rentalIncome
    /// Income from royalties
    case royalties
    /// Income from a business
    case businessIncome
    /// Foreign-earned income
    case foreignEarnedIncome
    /// Other types of ordinary income not categorized elsewhere
    case otherOrdinaryIncome
    
    // MARK: - Retirement
    
    /// Withdrawals from traditional IRAs
    case iraWithdrawal
    /// Income from converting traditional IRA to Roth IRA
    case rothConversion
    
    // MARK: - Other Excluded Income
    
    /// Distributions from a Health Savings Account (HSA) for qualified medical expenses
    case qualifiedHSADistributions
    /// Withdrawals from a Roth IRA (tax-free under qualifying conditions)
    case rothDistributions
    /// Income from gifts or inheritance
    case giftsOrInheritance
    /// Other forms of tax-exempt income
    case otherTaxExemptIncome
}

extension IncomeType: Identifiable {
    public var id: Self { self }
    
    static let taxExempt: [IncomeType] = [
        .taxExemptInterest,
        .qualifiedHSADistributions,
        .rothDistributions,
        .giftsOrInheritance,
        .otherTaxExemptIncome
    ]
    
    
    static let investment: [IncomeType] = [
        .interest,
        .shortTermCapitalGains,
        .longTermCapitalGains,
        .carryforwardLoss,
        .qualifiedDividends,
        .totalOrdinaryDividends
    ]
    
    
    static let  ordinary: [IncomeType] = [
        .wagesSelf,
        .wagesSpouse,
        .socialSecuritySelf,
        .socialSecuritySpouse,
        .rentalIncome,
        .royalties,
        .businessIncome,
        .foreignEarnedIncome,
        .iraWithdrawal,
        .rothConversion,
        .otherOrdinaryIncome,
    ]
    
}

extension IncomeType {
    var label: String {
        switch self {
        case .wagesSelf:
            return String(localized: "Wages (Self)")
        case .wagesSpouse:
            return String(localized: "Wages (Spouse)")
        case .socialSecuritySelf:
            return String(localized: "Social Security (Self)")
        case .socialSecuritySpouse:
            return String(localized: "Social Security (Spouse)")
        case .interest:
            return String(localized: "Interest")
        case .taxExemptInterest:
            return String(localized: "Tax-Exempt Interest")
        case .shortTermCapitalGains:
            return String(localized: "Short-Term Capital Gains")
        case .longTermCapitalGains:
            return String(localized: "Long-Term Capital Gains")
        case .carryforwardLoss:
            return String(localized: "Carryforward Loss")
        case .qualifiedDividends:
            return String(localized: "Qualified Dividends")
        case .totalOrdinaryDividends:
            return String(localized: "Total Ordinary Dividends")
        case .rentalIncome:
            return String(localized: "Rental Income")
        case .royalties:
            return String(localized: "Royalties")
        case .businessIncome:
            return String(localized: "Business Income")
        case .foreignEarnedIncome:
            return String(localized: "Foreign Earned Income")
        case .otherOrdinaryIncome:
            return String(localized: "Other Ordinary Income")
        case .iraWithdrawal:
            return String(localized: "IRA Withdrawal")
        case .rothConversion:
            return String(localized: "Roth Conversion")
        case .qualifiedHSADistributions:
            return String(localized: "Qualified HSA Distributions")
        case .rothDistributions:
            return String(localized: "Roth Distributions")
        case .giftsOrInheritance:
            return String(localized: "Gifts or Inheritance")
        case .otherTaxExemptIncome:
            return String(localized: "Other Tax-Exempt Income")
        }
    }
    
    var description: String {
        switch self {
        case .wagesSelf:
            return String(localized: "Wages earned by the filer")
        case .wagesSpouse:
            return String(localized: "Wages earned by the spouse")
        case .socialSecuritySelf:
            return String(localized: "Social Security benefits received by the filer")
        case .socialSecuritySpouse:
            return String(localized: "Social Security benefits received by the spouse")
        case .interest:
            return String(localized: "Taxable interest income")
        case .taxExemptInterest:
            return String(localized: "Interest income exempt from federal taxes")
        case .shortTermCapitalGains:
            return String(localized: "Short-term capital gains from investments")
        case .longTermCapitalGains:
            return String(localized: "Long-term capital gains from investments")
        case .carryforwardLoss:
            return String(localized: "Losses carried forward from previous years")
        case .qualifiedDividends:
            return String(localized: "Qualified dividends eligible for lower tax rates")
        case .totalOrdinaryDividends:
            return String(localized: "Total ordinary dividends, including both qualified and non-qualified")
        case .rentalIncome:
            return String(localized: "Income from rental properties")
        case .royalties:
            return String(localized: "Income from royalties")
        case .businessIncome:
            return String(localized: "Income from business activities")
        case .foreignEarnedIncome:
            return String(localized: "Income earned outside the United States")
        case .otherOrdinaryIncome:
            return String(localized: "Other miscellaneous ordinary income")
        case .iraWithdrawal:
            return String(localized: "Withdrawals from a traditional IRA")
        case .rothConversion:
            return String(localized: "Income from converting traditional IRA to Roth IRA")
        case .qualifiedHSADistributions:
            return String(localized: "Distributions from an HSA for qualified medical expenses")
        case .rothDistributions:
            return String(localized: "Withdrawals from a Roth IRA (tax-free under qualifying conditions)")
        case .giftsOrInheritance:
            return String(localized: "Income from gifts or inheritance")
        case .otherTaxExemptIncome:
            return String(localized: "Other forms of tax-exempt income")
        }
    }
}
