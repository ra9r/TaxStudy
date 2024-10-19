//
//  ExtractedView.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/19/24.
//
import SwiftUI

struct SidebarView: View {
    @Environment(TaxScenarioManager.self) var manager
    
    var body: some View {
        @Bindable var m = manager
        List {
            ForEach(manager.taxScenarios) { scenario in
                NavigationLink(scenario.name, value: scenario)
                    .contextMenu {
                        Button(action: {
                            print("Clicked Duplicate!")
                        }) {
                            Text("Duplicate")
                            Image(systemName: "doc.on.doc")
                        }
                        Button(action: {
                            manager.delete(id: scenario.id)
                        }) {
                            Text("Delete")
                            Image(systemName: "trash")
                        }
                    }            }
            .onMove(perform: move)
        }
        .frame(minWidth: 250)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                Button {
                    manager.add(TaxScenario(name: "New Scenario"))
                } label: {
                    Label("Add Scenario", systemImage: "plus")
                }
            }
        }
        .navigationTitle(manager.selectedTaxScenario.name)
    }
    
    func move(from source: IndexSet, to destination: Int) {
        manager.taxScenarios.move(fromOffsets: source, toOffset: destination)
    }
}
