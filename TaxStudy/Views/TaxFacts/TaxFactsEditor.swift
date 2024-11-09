//
//  Se.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/20/24.
//
import SwiftUI

struct TaxFactsEditor : View {
    @Environment(TaxFactsManager.self) var taxFactsManager
    @State var selectedSetting: TaxFactsListTypes = .generalInformation
    
    
    var body: some View {
        @Bindable var tfm = taxFactsManager
        NavigationSplitView {
            List(selection: $tfm.selectedFacts) {
                Section("Official") {
                    ForEach(tfm.officialFacts, id: \.id) { facts in
                        NavigationLink("\(facts.year.noFormat) - \(facts.name)", value: facts)
                            .contextMenu {
                                Button("Duplicate") {
                                    newShared(from: facts)
                                }
                            }
                    }
                }
                Section("Shared") {
                    ForEach(taxFactsManager.sharedFacts, id: \.id) { facts in
                        NavigationLink("\(facts.year.noFormat) - \(facts.name)", value: facts)
                            .contextMenu {
                                Button("Duplicate") {
                                    newShared(from: facts)
                                }
                                Button("Delete") {
                                    taxFactsManager.deleteSharedFact(id: facts.id)
                                }
                            }
                    }
                }
            }
            
            .frame(minWidth: 200)
            .navigationTitle("Tax Facts")
        } content: {
            List(TaxFactsListTypes.allCases, id: \.self, selection: $selectedSetting) { settingType in
                NavigationLink(settingType.rawValue, value: settingType)
            }
            .frame(minWidth: 180)
        } detail: {
            VStack {
                TaxFactsListView(facts: $tfm.selectedFacts, selectedSetting: selectedSetting)
            }
        }
        .navigationTitle("TaxFacts")
        .navigationSplitViewStyle(.prominentDetail)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    taxFactsManager.saveSharedFacts()
                    print("Shared TaxFacts Saved")
                } label: {
                    Label {
                        Text("Save")
                    } icon: {
                        Image(systemName:"square.and.arrow.down")
                    }
                }
            }
            
        }
    }
    
    func newShared(from source: TaxFacts) {
        let newFacts = source.deepCopy
        newFacts.name = generateUniqueID(baseID: source.name)
        print("Duplication: \(newFacts.id)")
        taxFactsManager.newShared(from: newFacts)
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
        TaxFacts.createNewTaxFacts(name: "Official", year: 2023),
        TaxFacts.createNewTaxFacts(name: "Official", year: 2024),
    ]
    TaxFactsEditor()
        .environment(TaxFactsManager())
}
