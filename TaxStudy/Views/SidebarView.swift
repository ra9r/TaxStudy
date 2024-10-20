//
//  ExtractedView.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/19/24.
//
import SwiftUI

struct SidebarView: View {
    @Environment(AppServices.self) var appServices
    @Binding var scenario: TaxScenario?
    
    init(_ scenario: Binding<TaxScenario?>) {
        self._scenario = scenario
    }
    
    var body: some View {
        List(selection: $scenario) {
            ForEach(appServices.data.scenarios) { scenario in
                NavigationLink(scenario.name, value: scenario)
                    .contextMenu {
                        Button(action: {
                            appServices.data.add(scenario.deepCopy)
                        }) {
                            Text("Duplicate")
                            Image(systemName: "doc.on.doc")
                        }
                        Button(action: {
                            appServices.data.delete(id: scenario.id)
                        }) {
                            Text("Delete")
                            Image(systemName: "trash")
                        }
                    }
            }
            .onMove(perform: move)
        }
        
        .frame(minWidth: 250)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                Button {
                    appServices.data.add(TaxScenario(name: "New Scenario"))
                } label: {
                    Label("Add Scenario", systemImage: "plus")
                }
            }
        }

    }
    
    func move(from source: IndexSet, to destination: Int) {
        appServices.data.scenarios.move(fromOffsets: source, toOffset: destination)
    }
}
