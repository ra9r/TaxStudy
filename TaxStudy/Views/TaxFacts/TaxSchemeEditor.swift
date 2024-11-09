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
        @Bindable var tsm = taxSchemeManager
        NavigationSplitView {
            List(selection: $tsm.selectedScheme) {
                Section("Official") {
                    ForEach(tsm.officialSchemes, id: \.id) { taxScheme in
                        NavigationLink("\(taxScheme.year.noFormat) - \(taxScheme.name)", value: taxScheme)
                            .contextMenu {
                                Button("Duplicate") {
                                    newSharedTaxScheme(from: taxScheme)
                                }
                            }
                    }
                }
                Section("Shared") {
                    ForEach(taxSchemeManager.sharedSchemes, id: \.id) { taxScheme in
                        NavigationLink("\(taxScheme.year.noFormat) - \(taxScheme.name)", value: taxScheme)
                            .contextMenu {
                                Button("Duplicate") {
                                    newSharedTaxScheme(from: taxScheme)
                                }
                                Button("Delete") {
                                    taxSchemeManager.deleteSharedTaxScheme(id: taxScheme.id)
                                }
                            }
                    }
                    .onMove(perform: taxSchemeManager.moveSharedTaxSchemes)
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
                TaxSchemeFactListView(taxScheme: $tsm.selectedScheme, selectedSetting: selectedSetting)
            }
        }
        .navigationTitle("Tax Scheme Editor")
        .navigationSplitViewStyle(.prominentDetail)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    taxSchemeManager.saveSharedTaxSchemes()
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
    
    func newSharedTaxScheme(from source: TaxScheme) {
        taxSchemeManager.newSharedTaxScheme(from: source, name: generateUniqueName(name: source.name))
    }
    
    func generateUniqueName(name: String) -> String {
        let existingNames = taxSchemeManager.allTaxSchemes().map { $0.id }
        var newName = "\(name) Copy"
        var copyNumber = 1

        // Check if the newID or its numbered versions already exist in the array
        while existingNames.contains(newName) {
            newName = "\(name) Copy \(copyNumber)"
            copyNumber += 1
        }

        return newName
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
