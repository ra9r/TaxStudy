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
            List(Array(appServices.data.facts.keys).sorted(), id: \.self,  selection: $selectedFacts) { key in
                NavigationLink("Facts: \(key)", value: key)
            }
        } content: {
            List(SettingTypes.allCases, id: \.self, selection: $selectedSetting) { settingType in
                NavigationLink(settingType.rawValue, value: settingType)
            }
        } detail: {
            if let selectedFacts {
                if let facts = appServices.data.facts[selectedFacts] {
                    switch selectedSetting {
                    case .ordinaryTaxBrackets:
                        TaxBracketEditor(taxBrackets: facts.ordinaryTaxBrackets)
                    case .capitalGainsTaxBrackets:
                        TaxBracketEditor(taxBrackets: facts.capitalGainTaxBrackets)
                    }
                    
                }
            } else {
                Text("Nothing to see here!")
            }
            
        }
    }
}

enum SettingTypes: String, CaseIterable {
    case ordinaryTaxBrackets = "Ordinary Tax Brackets"
    case capitalGainsTaxBrackets = "Capital Gains Tax Brackets"
}


