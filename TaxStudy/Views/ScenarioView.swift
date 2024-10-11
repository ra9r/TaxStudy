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
                .navigationTitle("Income")
            
            // Third Tab
            DeductionEditor()
                .tabItem {
                    Label("Deductions", systemImage: "person.crop.circle.fill")
                }
                .navigationTitle("Deductions")
            
            JSONView(taxScenario: manager.selectedTaxScenario)
                .tabItem {
                    Label("JSON Export", systemImage: "person.crop.circle.fill")
                }
                .navigationTitle("JSON Export")
        }
        .tint(Color.accentColor)
        .toolbar {
            // Add a button to the title bar's trailing side (right side)
            ToolbarItem(placement: .navigation) {
                Button(action: {
                    print("Loading ...")
                    do {
                        try manager.open(from: URL(fileURLWithPath: "/Users/rodney/Desktop/2024EstimatedTax.json"))
                    } catch {
                        print(error)
                    }
                }) {
                    Label("Refresh", systemImage: "arrow.clockwise")
                }
            }
        }
        .navigationTitle(manager.selectedTaxScenario.name)
    }
}

#Preview {
    @Previewable @State var manager = TaxScenarioManager()
    ScenarioView()
        .environment(TaxScenarioManager())
}
