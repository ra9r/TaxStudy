//
//  Se.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/20/24.
//
import SwiftUI

struct SettingsView : View {
    @Environment(TaxFactsManager.self) var taxFactsManager
    @State var selectedFacts: Int?
    @State var selectedSetting: SettingTypes = .ordinaryTaxBrackets
    
    
    var body: some View {
        @Bindable var manager = taxFactsManager
        NavigationSplitView {
            List(taxFactsManager.officialFacts.indices, id: \.self,  selection: $selectedFacts) { index in
                NavigationLink("Facts: \(taxFactsManager.officialFacts[index].id)", value: index)
            }
            .frame(minWidth: 200)
            .navigationTitle("Tax Facts")
        } content: {
            List(SettingTypes.allCases, id: \.self, selection: $selectedSetting) { settingType in
                NavigationLink(settingType.rawValue, value: settingType)
            }
            .frame(minWidth: 180)
        } detail: {
            if let selectedFacts {
                TaxFactsEditor(facts: $manager.officialFacts[selectedFacts], selectedSetting: selectedSetting)
            }
        }
        .onAppear {
            if selectedFacts == nil && taxFactsManager.officialFacts.isEmpty == false {
                selectedFacts = 0
            }
        }
    }
}




#Preview(traits: .sizeThatFitsLayout) { 
    @Previewable @State var facts: [TaxFacts] = [
        TaxFacts.createNewTaxFacts(id: "2023"),
        TaxFacts.createNewTaxFacts(id: "2024")
    ]
    SettingsView()
        .environment(TaxFactsManager())
}
