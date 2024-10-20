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
            List(Array(appServices.facts.keys).sorted(), id: \.self,  selection: $selectedFacts) { key in
                NavigationLink("Facts: \(key)", value: key)
            }
        } content: {
            List(SettingTypes.allCases, id: \.self, selection: $selectedSetting) { settingType in
                NavigationLink(settingType.rawValue, value: settingType)
            }
        } detail: {
            if let selectedFacts {
                if let facts = appServices.facts[selectedFacts] {
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
                    }
                }
            } else {
                Text("Nothing to see here!")
            }
            
        }
    }
}

enum SettingTypes: String, CaseIterable {
    case ordinaryTaxBrackets = "Ordinary Income Tax"
    case capitalGainsTaxBrackets = "Capital Gains Tax"
    case ssTaxThresholds = "Social Security Tax"
    case medicareTaxThresholds = "Medicare Tax"
    case provisionalIncomeThresholds = "Provisional Income"
}


