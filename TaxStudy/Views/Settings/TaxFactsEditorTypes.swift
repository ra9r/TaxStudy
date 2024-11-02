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
    case provisionalIncomeThresholds = "Provisional Income"
    case irmaaPartBSurcharges = "IRMAA Part B Surcharges"
    case irmaaPartDSurcharges = "IRMAA Part D Surcharges"
    
}
