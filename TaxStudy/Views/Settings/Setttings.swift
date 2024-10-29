//
//  Se.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/20/24.
//
import SwiftUI

struct SettingsView : View {
    @Binding var facts: [TaxFacts]
    @State var selectedFacts: Int?
    @State var selectedSetting: SettingTypes = .ordinaryTaxBrackets
    
    var body: some View {
        NavigationSplitView {
            List(facts.indices, id: \.self,  selection: $selectedFacts) { index in
                NavigationLink("Facts: \(facts[index].id)", value: index)
            }
            .frame(minWidth: 200)
            .navigationTitle("Tax Facts")
        } content: {
            List(SettingTypes.allCases, id: \.self, selection: $selectedSetting) { settingType in
                NavigationLink(settingType.rawValue, value: settingType)
            }
        } detail: {
            if let selectedFacts {
                switch selectedSetting {
                case .ordinaryTaxBrackets:
                    TaxBracketEditor(taxBrackets: $facts[selectedFacts].ordinaryTaxBrackets)
                case .capitalGainsTaxBrackets:
                    TaxBracketEditor(taxBrackets: $facts[selectedFacts].capitalGainTaxBrackets)
                case .ssTaxThresholds:
                    TaxBracketEditor(taxBrackets: $facts[selectedFacts].ssTaxThresholds)
                case .medicareTaxThresholds:
                    TaxBracketEditor(taxBrackets: $facts[selectedFacts].medicareTaxThresholds)
                case .provisionalIncomeThresholds:
                    TaxBracketEditor(taxBrackets: $facts[selectedFacts].provisionalIncomeThresholds)
                case .hsaLimits:
                    Text("HSA Limits")
                case .iraLimits:
                    Text("IRA Limits")
                case .irmaaSurcharges:
                    Text("IRMAA Surcharges")
                case .niiTax:
                    NIITEditor(facts: $facts[selectedFacts])
                case .standardDeductions:
                    Text("Standard Deductions")
                case .charitableDeductions:
                    Text("Charitable Deductions")
                case .earmingsLimits:
                    Text("Earning Limits for SSA Income")
                }
            } else {
                Text("Nothing to see here!")
            }
        }
        .onAppear {
            if selectedFacts == nil && facts.isEmpty == false {
                selectedFacts = 0
            }
        }
    }
}

enum SettingTypes: String, CaseIterable {
    case ordinaryTaxBrackets = "Ordinary Income"
    case capitalGainsTaxBrackets = "Capital Gains"
    case niiTax = "Net Invetment Income"
    case ssTaxThresholds = "Social Security"
    case medicareTaxThresholds = "Medicare"
    case provisionalIncomeThresholds = "Provisional Income"
    case hsaLimits = "HSAs"
    case iraLimits = "IRA and Roth"
    case irmaaSurcharges = "IRMAA Surcharges"
    case standardDeductions = "Standard Deductions"
    case charitableDeductions = "Charitable Deductions"
    case earmingsLimits = "SSA Earning Limits"
}


#Preview(traits: .sizeThatFitsLayout) { 
    @Previewable @State var facts: [TaxFacts] = [createEmptyTaxFacts(id: "2023"), createEmptyTaxFacts(id: "2024")]
    SettingsView(facts: $facts)
}
