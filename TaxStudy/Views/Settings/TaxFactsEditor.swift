//
//  TaxFactsEditor.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/29/24.
//
import SwiftUI

enum SettingTypes: String, CaseIterable {
    case standardDeductions = "Standard Deductions"
    case niiTax = "Net Invetment Income"
    case ordinaryTaxBrackets = "Ordinary Income"
    case capitalGainsTaxBrackets = "Capital Gains"
    case ssTaxThresholds = "Social Security"
    case medicareTaxThresholds = "Medicare"
    case provisionalIncomeThresholds = "Provisional Income"
    case hsaLimits = "HSAs"
    case iraLimits = "IRA and Roth"
    case irmaaSurcharges = "IRMAA Surcharges"
    case charitableDeductions = "Charitable Deductions"
    case earmingsLimits = "SSA Earning Limits"
}

struct TaxFactsEditor : View {
    @Binding var facts: TaxFacts
    @State var selectedSetting: SettingTypes = .ordinaryTaxBrackets
    
    var body: some View {
        NavigationSplitView {
            List(SettingTypes.allCases, id: \.self, selection: $selectedSetting) { settingType in
                NavigationLink(settingType.rawValue, value: settingType)
            }
            .frame(minWidth: 180)
        } detail: {
            switch selectedSetting {
            case .standardDeductions:
                StandardDeductionFactsEditor(facts: $facts)
            case .ordinaryTaxBrackets:
                TaxBracketEditor(taxBrackets: $facts.ordinaryTaxBrackets)
            case .capitalGainsTaxBrackets:
                TaxBracketEditor(taxBrackets: $facts.capitalGainTaxBrackets)
            case .ssTaxThresholds:
                TaxBracketEditor(taxBrackets: $facts.ssTaxThresholds)
            case .medicareTaxThresholds:
                TaxBracketEditor(taxBrackets: $facts.medicareTaxThresholds)
            case .provisionalIncomeThresholds:
                TaxBracketEditor(taxBrackets: $facts.provisionalIncomeThresholds)
            case .hsaLimits:
                Text("HSA Limits")
            case .iraLimits:
                Text("IRA Limits")
            case .irmaaSurcharges:
                Text("IRMAA Surcharges")
            case .niiTax:
                NIITFactsEditor(facts: $facts)
            case .charitableDeductions:
                Text("Charitable Deductions")
            case .earmingsLimits:
                Text("Earning Limits for SSA Income")
            }
        }
    }
}

#Preview {
    @Previewable @State var taxFactService = TaxFactsService()
    TaxFactsEditor(facts: $taxFactService.officialFacts[0])
}
