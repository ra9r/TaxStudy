//
//  Se.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/20/24.
//
import SwiftUI

struct SettingsView : View {
    @Environment(AppServices.self) var appServices
    @State var selectedFacts: String?
    @State var selectedSetting: SettingTypes = .ordinaryTaxBrackets
    
    var body: some View {
        NavigationSplitView {
            List(appServices.facts.map({ $0.id }), id: \.self,  selection: $selectedFacts) { id in
                NavigationLink("Facts: \(id)", value: id)
            }
        } content: {
            List(SettingTypes.allCases, id: \.self, selection: $selectedSetting) { settingType in
                NavigationLink(settingType.rawValue, value: settingType)
            }
        } detail: {
            if let selectedFacts {
                if let facts = appServices.facts(for: selectedFacts) {
                    switch selectedSetting {
                    case .ordinaryTaxBrackets:
                        TaxBracketEditor(taxBrackets: facts.ordinaryTaxBrackets)
                    case .capitalGainsTaxBrackets:
                        TaxBracketEditor(taxBrackets: facts.capitalGainTaxBrackets)
                    case .ssTaxThresholds:
                        TaxBracketEditor(taxBrackets: facts.ssTaxThresholds)
                    case .medicareTaxThresholds:
                        TaxBracketEditor(taxBrackets: facts.medicareTaxThresholds)
                    case .provisionalIncomeThresholds:
                        TaxBracketEditor(taxBrackets: facts.provisionalIncomeThresholds)
                    case .hsaLimits:
                        Text("HSA Limits")
                    case .iraLimits:
                        Text("IRA Limits")
                    case .irmaaSurcharges:
                        Text("IRMAA Surcharges")
                    case .niiTax:
                        Text("Net Invetment Income Tax (NIIT)")
                    case .standardDeductions:
                        Text("Standard Deductions")
                    case .charitableDeductions:
                        Text("Charitable Deductions")
                    case .earmingsLimits:
                        Text("Earning Limits for SSA Income")
                    }
                }
            } else {
                Text("Nothing to see here!")
            }
            
        }
    }
}

enum SettingTypes: String, CaseIterable {
    case ordinaryTaxBrackets = "Ordinary Income"
    case capitalGainsTaxBrackets = "Capital Gains"
    case ssTaxThresholds = "Social Security"
    case medicareTaxThresholds = "Medicare"
    case provisionalIncomeThresholds = "Provisional Income"
    case hsaLimits = "HSAs"
    case iraLimits = "IRA and Roth"
    case irmaaSurcharges = "IRMAA Surcharges"
    case niiTax = "Net Invetment Income"
    case standardDeductions = "Standard Deductions"
    case charitableDeductions = "Charitable Deductions"
    case earmingsLimits = "SSA Earning Limits"
}


