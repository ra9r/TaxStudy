//
//  ContentView.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 9/27/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(TaxScenarioManager.self) var manager

    
    var body: some View {
        @Bindable var m = manager
        NavigationSplitView {
            List(manager.taxScenarios, selection: $m.selectedTaxScenario) { scenario in
                NavigationLink(scenario.name, value: scenario)
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
            
        } detail: {
            ScenarioView()
                
        }
    }
}

#Preview {
    ContentView()
        .environment(TaxScenarioManager())
}
