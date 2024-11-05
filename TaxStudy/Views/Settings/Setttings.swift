//
//  Se.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/20/24.
//
import SwiftUI

struct SettingsView : View {
    @Environment(TaxFactsManager.self) var taxFactsManager
    @State var selectedFacts: String?
    @State var selectedSetting: TaxFactsEditorTypes = .ordinaryTaxBrackets
    @State var isEditable: Int?
    
    
    var body: some View {
        @Bindable var manager = taxFactsManager
        NavigationSplitView {
            List(selection: $selectedFacts) {
                Section("Official") {
                    ForEach(taxFactsManager.officialFacts.indices, id: \.self) { index in
                        let id = taxFactsManager.officialFacts[index].id
                        NavigationLink("Facts: \(id)", value: id)
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
                        let id = taxFactsManager.sharedFacts[index].id
                        if let isEditable = isEditable, isEditable == index {
                            TextField("Foo", text: $manager.sharedFacts[index].id)
                        } else {
                            NavigationLink("Facts: \(id)", value: id)
                                .contextMenu {
                                    Button("Rename") {  
                                        isEditable = index
                                    }
                                    Button("Duplicate") {
                                        newShared(from: taxFactsManager.sharedFacts[index])
                                    }
                                    Button("Delete") {
                                        taxFactsManager.sharedFacts.remove(
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
                if manager.officialFacts.first(where: { $0.id == selectedFacts}) != nil {
                    TaxFactsEditor(facts: $manager.officialFacts.first(where: { $0.id == selectedFacts})!, selectedSetting: selectedSetting)
                } else {
                    TaxFactsEditor(facts: $manager.sharedFacts.first(where: { $0.id == selectedFacts})!, selectedSetting: selectedSetting)
                }
            }
        }
        .navigationTitle("TaxFacts")
        .navigationSplitViewStyle(.prominentDetail)
        .onAppear {
            if selectedFacts == nil && taxFactsManager.officialFacts.isEmpty == false {
                selectedFacts = nil
            }
        }
    }
    
    func newShared(from source: TaxFacts) {
        let newFacts = source.deepCopy
        newFacts.id = generateUniqueID(baseID: source.id)
        print("Duplication: \(newFacts.id)")
        taxFactsManager.sharedFacts.append(newFacts)
    }
    
    func generateUniqueID(baseID: String) -> String {
        let existingIDs = taxFactsManager.allFacts().map { $0.id }
        var newID = "\(baseID) Copy"
        var copyNumber = 1

        // Check if the newID or its numbered versions already exist in the array
        while existingIDs.contains(newID) {
            newID = "\(baseID) Copy \(copyNumber)"
            copyNumber += 1
        }

        return newID
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
