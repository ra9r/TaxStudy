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
        
        TabView {
            // First Tab
            ReportView(ts: manager.selectedTaxScenario)
                .tabItem {
                    Label("Overview", systemImage: "house.fill")
                }
            
            // Second Tab
            IncomeEditor()
                .tabItem {
                    Label("Income", systemImage: "gearshape.fill")
                }
            
            // Third Tab
            DeductionEditor()
                .tabItem {
                    Label("Deductions", systemImage: "person.crop.circle.fill")
                }
            
            JSONView(taxScenario: manager.selectedTaxScenario)
                .tabItem {
                    Label("JSON Export", systemImage: "person.crop.circle.fill")
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
