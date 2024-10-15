//
//  TaxAdjustment.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/14/24.
//

import SwiftUI

enum TaxAdjustmentType : String, CaseIterable {
    /// All contributions made to traditional individual retirement accounts (IRAs)
    /// and qualified plans such as 401(k), 403(b), and 457 plans are deductible.
    case iraOr401kContribution
    
    /// All contributions to Health Savings Accounts (HSAs) and Archer Medical
    /// Savings Accounts (MSAs) are fully deductible, as long as taxpayers do not
    /// have access to any kind of group policy coverage, including that offered by
    /// fraternal or professional organizations. The purchase of a qualified
    /// high-deductible health insurance policy is also required.
    case hsaContribution
    
    /// Interest that's paid on federal student loans is deductible up to a certain
    /// amount. Anyone who pays more than $600 in student loan interest should
    /// receive Form 1098-E: Student Loan Interest Statement. You are allowed to
    /// deduct up to $2,500 or the total amount of interest paid—whichever is lower.
    case studentLoanInterest
    
    /// Virtually any expense related to the operation of a sole proprietorship is
    /// deductible on Schedule C. This includes rent, utilities, the cost of equipment
    /// and supplies, insurance, legal fees, employee salaries, and contract labor.
    case businessExpenses
    
    /// Any penalties paid for the early withdrawal of money from a CD or savings
    /// bond that is reported on Form 1099-INT or 1099-DIV can be deducted.
    case earlyWithDrawalPenalties
    
    /// Catch all adjustment for supporting future changes to the tax code.
    case customAdjustment
}

extension TaxAdjustmentType : DeductionType {
    var id: String {
        return self.rawValue
    }
    
    var label: String {
        switch self {
        case .iraOr401kContribution:
            return String(localized: "IRA or 401(k) Contribution")
        case .hsaContribution:
            return String(localized: "HSA or MSA Contribution")
        case .studentLoanInterest:
            return String(localized: "Student Loan Interest")
        case .businessExpenses:
            return String(localized: "Business Expenses")
        case .earlyWithDrawalPenalties:
            return String(localized: "Early Withdrawal Penalties")
        case .customAdjustment:
            return String(localized: "Custom Adjustment")
        }
    }
    
    var description: String {
        switch self {
        case .iraOr401kContribution:
            return String(localized: "All contributions made to traditional individual retirement accounts (IRAs) and qualified plans such as 401(k), 403(b), and 457 plans are deductible.")
        case .hsaContribution:
            return String(localized: "All contributions to Health Savings Accounts (HSAs) and Archer Medical Savings Accounts (MSAs) are fully deductible, as long as taxpayers do not have access to any kind of group policy coverage, including that offered by fraternal or professional organizations. The purchase of a qualified high-deductible health insurance policy is also required.")
        case .studentLoanInterest:
            return String(localized: "Interest that's paid on federal student loans is deductible up to a certain amount. Anyone who pays more than $600 in student loan interest should receive Form 1098-E: Student Loan Interest Statement. You are allowed to deduct up to $2,500 or the total amount of interest paid—whichever is lower.")
        case .businessExpenses:
            return String(localized: "Virtually any expense related to the operation of a sole proprietorship is deductible on Schedule C. This includes rent, utilities, the cost of equipment and supplies, insurance, legal fees, employee salaries, and contract labor.")
        case .earlyWithDrawalPenalties:
            return String(localized: "Any penalties paid for the early withdrawal of money from a CD or savings bond that is reported on Form 1099-INT or 1099-DIV can be deducted.")
        case .customAdjustment:
            return String(localized: "Catch all adjustment for supporting future changes to the tax code.")
        }
    }
}

