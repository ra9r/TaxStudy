//
//  TaxFactsEditorTypes.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/31/24.
//


enum TaxFactsEditorTypes: String, CaseIterable {
    case standardDeductions = "Standard Deductions"
    case niiTax = "Net Invetment Income"
    case ordinaryTaxBrackets = "Ordinary Income"
    case capitalGainsTaxBrackets = "Capital Gains"
    case ficaTaxThresholds = "FICA Taxes"
    case medicareTaxThresholds = "Medicare"
    case provisionalIncomeThresholds = "Provisional Income"
    case hsaLimits = "HSAs"
    case iraLimits = "IRA and Roth"
    case irmaaSurcharges = "IRMAA Surcharges"
    case charitableDeductions = "Charitable Deductions"
    case earmingsLimits = "SSA Earning Limits"
}
