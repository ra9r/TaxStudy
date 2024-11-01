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
    @State var selectedSetting: TaxFactsEditorTypes = .ordinaryTaxBrackets
    
    
    var body: some View {
        @Bindable var manager = taxFactsManager
        NavigationSplitView {
            List(selection: $selectedFacts) {
                Section("Official") {
                    ForEach(taxFactsManager.officialFacts.indices, id: \.self) { index in
                        NavigationLink("Facts: \(taxFactsManager.officialFacts[index].id)", value: index)
                    }
                }
                Section("Shared") {
                    ForEach(taxFactsManager.sharedFacts.indices, id: \.self) { index in
                        NavigationLink("Facts: \(taxFactsManager.officialFacts[index].id)", value: index)
                    }
                }
            }
        
            .frame(minWidth: 200)
            .navigationTitle("Tax Facts")
        } content: {
            List(TaxFactsEditorTypes.allCases, id: \.self, selection: $selectedSetting) { settingType in
                NavigationLink(settingType.rawValue, value: settingType)
            }
            .frame(minWidth: 180)
        } detail: {
            if let selectedFacts {
                TaxFactsEditor(facts: $manager.officialFacts[selectedFacts], selectedSetting: selectedSetting)
            }
        }
        .navigationTitle("TaxFacts")
        .navigationSplitViewStyle(.prominentDetail)
        .onAppear {
            if selectedFacts == nil && taxFactsManager.officialFacts.isEmpty == false {
                selectedFacts = 0
            }
        }
//        .frame(minWidth: 1150, minHeight: 400)
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
