//
//  Se.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/20/24.
//
import SwiftUI

struct TaxSchemeEditor : View {
    @Environment(TaxSchemeManager.self) var taxSchemeManager
    @State var selectedSetting: TaxSchemeFactTypes = .generalInformation
    
    
    var body: some View {
        @Bindable var tfm = taxSchemeManager
        NavigationSplitView {
            List(selection: $tfm.selectedScheme) {
                Section("Official") {
                    ForEach(tfm.officialSchemes, id: \.id) { facts in
                        NavigationLink("\(facts.year.noFormat) - \(facts.name)", value: facts)
                            .contextMenu {
                                Button("Duplicate") {
                                    newShared(from: facts)
                                }
                            }
                    }
                }
                Section("Shared") {
                    ForEach(taxSchemeManager.sharedSchemes, id: \.id) { facts in
                        NavigationLink("\(facts.year.noFormat) - \(facts.name)", value: facts)
                            .contextMenu {
                                Button("Duplicate") {
                                    newShared(from: facts)
                                }
                                Button("Delete") {
                                    taxSchemeManager.deleteSharedFact(id: facts.id)
                                }
                            }
                    }
                }
            }
            
            .frame(minWidth: 200)
        } content: {
            List(TaxSchemeFactTypes.allCases, id: \.self, selection: $selectedSetting) { settingType in
                NavigationLink(settingType.rawValue, value: settingType)
            }
            .frame(minWidth: 180)
        } detail: {
            VStack {
                TaxSchemeFactListView(taxScheme: $tfm.selectedScheme, selectedSetting: selectedSetting)
            }
        }
        .navigationTitle("Tax Scheme Editor")
        .navigationSplitViewStyle(.prominentDetail)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    taxSchemeManager.saveSharedFacts()
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
    
    func newShared(from source: TaxScheme) {
        let newFacts = source.deepCopy
        newFacts.name = generateUniqueID(baseID: source.name)
        print("Duplication: \(newFacts.id)")
        taxSchemeManager.newShared(from: newFacts)
    }
    
    func generateUniqueID(baseID: String) -> String {
        let existingIDs = taxSchemeManager.allFacts().map { $0.id }
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
    @Previewable @State var facts: [TaxScheme] = [
        TaxScheme.createNewTaxScheme(name: "Official", year: 2023),
        TaxScheme.createNewTaxScheme(name: "Official", year: 2024),
    ]
    TaxSchemeEditor()
        .environment(TaxSchemeManager())
}
