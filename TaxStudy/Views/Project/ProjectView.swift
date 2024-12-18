//
//  SideMenuView.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/24/24.
//

import SwiftUI
import KeyWindow

struct ProjectView : View {
    @Environment(TaxSchemeManager.self) var taxFactsManager
    @Binding var document: TaxProjectDocument
    @State var selectedScenario: TaxScenario?
    
    
    init(_ document: Binding<TaxProjectDocument>) {
        _document = document
    }
    
    var body: some View {
        NavigationSplitView {
            List(selection: $selectedScenario) {
                ForEach(document.scenarios, id:\.id) { scenario in
                    let name = scenario.name
                    NavigationLink(name, value: scenario)
                        .contextMenu {
                            Button("Duplicate") {
                                duplicate(scenario)
                            }
                            Button("Delete", role: .destructive) {
                                delete(scenario)
                            }
                        }
                }
                .onMove(perform: move)
            }
        } detail: {
            if let selectedScenario {
                ScenarioView(scenario: Binding(
                    get: { selectedScenario },
                    set: { newValue in
                        self.selectedScenario = newValue
                    }
                ), embeddedFacts: document.taxSchemes)
            } else {
                ContentUnavailableView("No Scenario Selected", image: "wrench")
            }
        }
        .toolbar {
            ToolbarItem {
                Button {
                    newScenario()
                } label: {
                    Image(systemName: "plus")
                }
                .buttonStyle(.plain)
            }
        }
        .frame(minWidth: 1100)
        .keyWindow(TaxProjectDocument.self, $document)        
    }
    
    func newScenario() {
        let newScenario = TaxScenario(name: "New Scenario", taxSchemeId: TaxScheme.official2024.id)
        document.scenarios.append(newScenario)
    }
    
    func move(from source: IndexSet, to destination: Int) {
        document.scenarios.move(fromOffsets: source, toOffset: destination)
    }
    
    func delete(_ scenario: TaxScenario) {
        document.scenarios.removeAll(where: { $0.id == scenario.id })
    }
    
    func duplicate(_ scenario: TaxScenario) {
        let duplicateScenario = scenario.deepCopy
        duplicateScenario.name = generateUniqueName(name: scenario.name)
        document.scenarios.append(duplicateScenario)
    }
    
    func generateUniqueName(name: String) -> String {
        let existingNames = document.scenarios.map { $0.name }
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
