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
                ), embeddedFacts: document.facts)
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
        let newScenario = TaxScenario(name: "New Scenario", facts: TaxScheme.official2024.id)
        document.scenarios.append(newScenario)
    }
    
    func move(from source: IndexSet, to destination: Int) {
        document.scenarios.move(fromOffsets: source, toOffset: destination)
    }
    
    func delete(_ scenario: TaxScenario) {
        document.scenarios.removeAll(where: { $0.id == scenario.id })
    }
    
    func duplicate(_ scenario: TaxScenario) {
        document.scenarios.append(scenario.deepCopy)
    }
}
