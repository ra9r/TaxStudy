//
//  ExtractedView.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/19/24.
//
import SwiftUI

struct SidebarView: View {
    @Environment(AppServices.self) var appSErvices
    @Binding var scenario: TaxScenario?
    
    init(_ scenario: Binding<TaxScenario?>) {
        self._scenario = scenario
    }
    
    var body: some View {
        List(appSErvices.data.scenarios, selection: $scenario) { scenario in
            NavigationLink(scenario.name, value: scenario)
                .contextMenu {
                    Button(action: {
                        print("Clicked Duplicate!")
                    }) {
                        Text("Duplicate")
                        Image(systemName: "doc.on.doc")
                    }
                    Button(action: {
                        appSErvices.data.delete(id: scenario.id)
                    }) {
                        Text("Delete")
                        Image(systemName: "trash")
                    }
                }
//                .onMove(perform: move)
        }
        
        .frame(minWidth: 250)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                Button {
                    appSErvices.data.add(TaxScenario(name: "New Scenario"))
                } label: {
                    Label("Add Scenario", systemImage: "plus")
                }
            }
        }

    }
    
    func move(from source: IndexSet, to destination: Int) {
        appSErvices.data.scenarios.move(fromOffsets: source, toOffset: destination)
    }
}
