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
    @State var isEditable: Int?
    
    
    var body: some View {
        @Bindable var manager = taxFactsManager
        NavigationSplitView {
            List(selection: $selectedFacts) {
                Section("Official") {
                    ForEach(taxFactsManager.officialFacts.indices, id: \.self) { index in
                        NavigationLink("Facts: \(taxFactsManager.officialFacts[index].id)", value: index)
                            .contextMenu {
                                Button("Duplicate") {
                                    newShared(from: taxFactsManager.officialFacts[index])
                                }
                            }
                    }
                }
                Section("Shared") {
                    @Bindable var manager = taxFactsManager
                    ForEach(taxFactsManager.sharedFacts.indices, id: \.self) { index in
                        if let isEditable = isEditable, isEditable == index {
                            TextField("Foo", text: $manager.sharedFacts[index].id)
                        } else {
                            NavigationLink("Facts: \(taxFactsManager.sharedFacts[index].id)", value: index)
                                .contextMenu {
                                    Button("Rename") {
                                        isEditable = index
                                    }
                                }
                        }
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
    }
    
    func newShared(from source: TaxFacts) {
        let newFacts = source.deepCopy
        print("Duplication: \(newFacts.id)")
        taxFactsManager.sharedFacts.append(newFacts)
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
