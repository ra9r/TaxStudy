//
//  ScenarioView.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/1/24.
//
import SwiftUI

struct ScenarioView : View {
    @Environment(TaxScenarioManager.self) var manager
    
    var body: some View {
        ScenarioResults(scenario: manager.selectedTaxScenario)
        TabView {
            // First Tab
            Text("Overview \(manager.selectedTaxScenario.name)")
                .tabItem {
                    Label("Overview", systemImage: "house.fill")
                }
            
            // Second Tab
            ScenarioEditor()
                .tabItem {
                    Label("Income", systemImage: "gearshape.fill")
                }
            
            // Third Tab
            Text("Deductions Tab Content")
                .tabItem {
                    Label("Deductions", systemImage: "person.crop.circle.fill")
                }
            Text("Rates Tab Content")
                .tabItem {
                    Label("Rates", systemImage: "person.crop.circle.fill")
                }
        }
        .toolbar {
            // Add a button to the title bar's trailing side (right side)
            ToolbarItem(placement: .navigation) {
                Button(action: {
                    print("Button clicked!")
                }) {
                    Label("Refresh", systemImage: "arrow.clockwise")
                }
            }
        }
        .navigationTitle(manager.selectedTaxScenario.name)
    }
}
