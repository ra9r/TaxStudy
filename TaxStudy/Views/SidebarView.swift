//
//  ExtractedView.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/19/24.
//
import SwiftUI

struct SidebarView: View {
    @Environment(AppServices.self) var appServices

    
    var body: some View {
        @Bindable var s = appServices
        List(selection: $s.activeScenario) {
            ForEach(s.data.scenarios) { scenario in
                NavigationLink(scenario.name, value: scenario)
                    .contextMenu {
                        Button(action: {
                            s.data.add(scenario.deepCopy)
                        }) {
                            Text("Duplicate")
                            Image(systemName: "doc.on.doc")
                        }
                        Button(action: {
                            s.data.delete(id: scenario.id)
//                            s.activeScenario = nil
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
